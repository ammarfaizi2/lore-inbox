Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSLCUrF>; Tue, 3 Dec 2002 15:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSLCUrF>; Tue, 3 Dec 2002 15:47:05 -0500
Received: from [209.184.141.189] ([209.184.141.189]:52314 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265657AbSLCUrE>;
	Tue, 3 Dec 2002 15:47:04 -0500
Subject: 2.4.20-aa1 questions.
From: Austin Gonyou <austin@coremetrics.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Coremetrics, Inc.
Message-Id: <1038948847.1772.7.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 03 Dec 2002 14:54:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what do the following patches actually *fix*?

00_backout-gcc-3_0-patch-1
00_gcc-30-volatile-xtime-1

I'm trying to get 2.4.20 patched up by using the -aa split patches for
2.4.20 and I'm incorporating only the things I want, but I use gcc 3.2
for compiling, and these confused me a bit.

-- 
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.
