Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbSI2S4j>; Sun, 29 Sep 2002 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSI2S4j>; Sun, 29 Sep 2002 14:56:39 -0400
Received: from gate.perex.cz ([194.212.165.105]:15888 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261730AbSI2S4i>;
	Sun, 29 Sep 2002 14:56:38 -0400
Date: Sun, 29 Sep 2002 21:01:23 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [9/10] - 2002/08/01
Message-ID: <Pine.LNX.4.33.0209292054180.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 9-th patch is large. Please, download it from this URL:

ftp://ftp.alsa-project.org/pub/kernel-patches/set#1/9.patch

						Jaroslav

ChangeSet@1.605.2.20, 2002-09-26 14:07:49+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/08/01 :
    - CS46xx - added support for the new DSP image
      - S/PDIF and dual-codec support
    - sequencer
      - fixed deadlock at snd_seq_timer_start/stop


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

