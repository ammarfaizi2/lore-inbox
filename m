Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282393AbRKXHjt>; Sat, 24 Nov 2001 02:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282389AbRKXHjj>; Sat, 24 Nov 2001 02:39:39 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:21890 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S282390AbRKXHja>;
	Sat, 24 Nov 2001 02:39:30 -0500
Date: Sat, 24 Nov 2001 00:33:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, zab@zabbo.net
Subject: No recording on maestro3 (hp omnibook xe3)
Message-ID: <20011124003330.A106@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I do cat /dev/dsp, I get no data, and 

Nov 24 00:31:55 amd kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 0 swptr 0
Nov 24 00:31:58 amd last message repeated 3 times

in the log. Is there way to help me? linux 2.4.14
							Pavel
-- 
<sig in construction>
