Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTANQEI>; Tue, 14 Jan 2003 11:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTANQEH>; Tue, 14 Jan 2003 11:04:07 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:60632 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S264690AbTANQCl>; Tue, 14 Jan 2003 11:02:41 -0500
Date: Tue, 14 Jan 2003 17:11:37 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: audio resamples itself
Message-ID: <Pine.LNX.4.51.0301141703080.7796@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i put my hdd to a different computer, which has:
00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2)
Chipset AC'97 Audio Controller (rev 12)

i noticed that when i play music with xmms it has the habit of changing
the sampling rate to something that sounds like 11k, (sharp aliased sound)
when eg. i open/close windows, click, etc. I know that i810 can handle
only 48k, i changed xmms preferences to play at 48k, but it still does it.

The previous computer had an sb live and it was fine.

Did anybody notice similar behaviour with this driver / chip ?

Regards,
Maciej

