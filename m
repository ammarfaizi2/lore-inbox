Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDUDz4>; Sat, 20 Apr 2002 23:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDUDzz>; Sat, 20 Apr 2002 23:55:55 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:31752 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S293187AbSDUDzz>;
	Sat, 20 Apr 2002 23:55:55 -0400
Date: Sat, 20 Apr 2002 23:55:50 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: New and Improved...Watchdog Updates
Message-ID: <Pine.LNX.4.33.0204202351550.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to something slightly different this time.  The latest updates of
my updates are in http://osinvestor.com/wd/
Patches in there are against 2.4.19-pre7, 2.4.19-pre7-ac2 and a very rough,
completely not-looked-at patch against 2.5.8.  The 2.5 patch is just to
put it out there, I haven't even looked at what changes have been made in
2.5 to the various drivers nor which direction changes should be moved
(forward port, backward port, sideways port, whatever).  From now on I'll
always dump the latest versions of my watchdog patches into
http://osinvestor.com/wd/

Also, seeing as how bzimage.org seems to have stopped doing it, I'm also
going to try to post incrememental patches of Alan Cox's tree in
http://osinvestor.com/ac/
If you take a look now, there's already two sets in there, from
2.4.19-pre5-ac3 -> 2.4.19-pre7-ac1 and
2.4.19-pre7-ac1 -> 2.4.19-pre7-ac2
in plain text, gzipped, and bzipped formats.

Regards,
Rob Radez

