Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbSJAQo6>; Tue, 1 Oct 2002 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbSJAQo5>; Tue, 1 Oct 2002 12:44:57 -0400
Received: from gate.perex.cz ([194.212.165.105]:33287 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262171AbSJAQo2>;
	Tue, 1 Oct 2002 12:44:28 -0400
Date: Tue, 1 Oct 2002 18:46:11 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [4/12] - 2002/08/14
Message-ID: <Pine.LNX.4.33.0210011844330.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A big one. Please, download it here:
ftp://ftp.alsa-project.org/pub/kernel-patches/set#2/4.patch

						Jaroslav

ChangeSet@1.647, 2002-10-01 09:25:18+02:00, perex@suse.cz
  ALSA update 2002/08/14 :
    - added USB Audio and USB MIDI drivers
    - VIA686
      - AC97 cold reset only when AC-link is down

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

