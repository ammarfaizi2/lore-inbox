Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEWJei>; Thu, 23 May 2002 05:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSEWJeh>; Thu, 23 May 2002 05:34:37 -0400
Received: from gate.perex.cz ([194.212.165.105]:51210 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S310206AbSEWJeh>;
	Thu, 23 May 2002 05:34:37 -0400
Date: Thu, 23 May 2002 12:32:09 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: ALSA development <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Latest ALSA code available for tests
Message-ID: <Pine.LNX.4.33.0205231221510.1197-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	the latest ALSA -> kernel patch is available for tests at

ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-2002-05-23-1-linux-2.5.17-cs1.582.patch.gz

	I'd like to ask interested people to test this patch and report
especially compilation problems, because there are some fixes in code
dependency for OSS emulation layer. Also Hammerfall DSP code was recently
added.

					Thank you,
						Jaroslav

Note: cs1.582 really means that patch was made against ChangeSet 1.582.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

