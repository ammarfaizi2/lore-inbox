Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbRCPWS4>; Fri, 16 Mar 2001 17:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCPWSq>; Fri, 16 Mar 2001 17:18:46 -0500
Received: from hansel.mnstate.edu ([199.17.103.2]:33798 "EHLO
	hansel.mnstate.edu") by vger.kernel.org with ESMTP
	id <S131412AbRCPWSd>; Fri, 16 Mar 2001 17:18:33 -0500
Date: Fri, 16 Mar 2001 16:17:33 -0600 (CST)
From: Mark Hansel <lists@hansel.mnstate.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: X freeze/ kernel 4.2/ gnome/ alpha LX164
In-Reply-To: <Pine.LNX.4.33.0103041142410.1680-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103161608480.3472-100000@hansel.mnstate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this belong elsewhere? outline follows, details available.

I have a series of log entries that look like this:
	got res[xxxx:xxxx] for resource X of <device follows>

One device was the 21140 chip on my ethernet card. A few were for the
matrox video card.

Symptoms were frozen keyboard, but able to get in fro 2d system. X was
very busy (95% of CPU). Killed softare piece by piece with no change.
Killed gdm. No change.

Runlevel change to 5 got me into gnome, switching back to 3 got back the
frozen keyboard.

Reboot required.

mhansel
hansel@mnstate.edu


