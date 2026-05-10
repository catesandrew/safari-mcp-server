export interface SafariSessionOptions {
  enableInspection?: boolean;
  enableProfiling?: boolean;
  usesTechnologyPreview?: boolean;
  /**
   * When false, SafariDriver will reuse the existing Safari browser profile
   * (cookies/cache/session). This improves persistence across sessions.
   * Defaults to false (persist by default).
   */
  useCleanSession?: boolean;
}

export interface SafariSession {
  driver: any; // WebDriver instance - using any to avoid import issues
  sessionId: string;
  options: SafariSessionOptions;
  createdAt: Date;
}

export interface ConsoleLogEntry {
  level: string;
  message: string;
  timestamp: number;
  source?: string;
}

export interface NetworkLogEntry {
  method: string;
  url: string;
  status?: number;
  requestHeaders?: Record<string, string>;
  responseHeaders?: Record<string, string>;
  timestamp: number;
  duration?: number;
}

export interface ElementInspectionResult {
  tagName: string;
  text: string;
  attributes: Record<string, string>;
  computedStyles?: Record<string, string>;
  boundingRect?: {
    x: number;
    y: number;
    width: number;
    height: number;
  };
}

export interface PerformanceMetrics {
  navigationStart?: number;
  loadEventEnd?: number;
  domContentLoadedEventEnd?: number;
  firstPaint?: number;
  firstContentfulPaint?: number;
}

export interface SafariCapabilities {
  browserName: string;
  browserVersion: string;
  platformName: string;
  acceptInsecureCerts?: boolean;
  pageLoadStrategy?: 'normal' | 'eager' | 'none';
  unhandledPromptBehavior?: 'dismiss' | 'accept' | 'dismiss and notify' | 'accept and notify' | 'ignore';
  'safari:automaticInspection'?: boolean;
  'safari:automaticProfiling'?: boolean;
  'safari:useTechnologyPreview'?: boolean;
}

export type LogLevel = 'ALL' | 'DEBUG' | 'INFO' | 'WARNING' | 'SEVERE';
