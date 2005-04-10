Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVDJIY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVDJIY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 04:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVDJIY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 04:24:56 -0400
Received: from [83.246.78.200] ([83.246.78.200]:1961 "EHLO srvh02.vc-server.de")
	by vger.kernel.org with ESMTP id S261439AbVDJIYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 04:24:54 -0400
Date: Sun, 10 Apr 2005 08:26:09 +0000
From: Dennis Heuer <dh@triple-media.com>
Subject: 2.6.11.x: bootprompt: ALSA: no soundcard detected
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.5
Message-Id: <1113121569l.584l.0l@Foo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I switched from 2.4 to 2.6.11 and found that the hard power-down now definetly needs ACPI, which stopped my soundplayer life from playing (stucking display and no sound), though. I installed 2.6.11.4, 2.6.11.5, and 2.6.11.7 but all three broke the hardware detection on my system. Now, with or without ACPI, the soundcard isn't even found.

There is no further error message, linux installs as always.

Regards,

Dennis Heuer

