Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSLFOsB>; Fri, 6 Dec 2002 09:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSLFOsB>; Fri, 6 Dec 2002 09:48:01 -0500
Received: from rakis.net ([216.235.252.212]:1676 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S262418AbSLFOr7>;
	Fri, 6 Dec 2002 09:47:59 -0500
Date: Fri, 6 Dec 2002 09:55:36 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: linux-kernel@vger.kernel.org
Subject: Dazed and Confused
Message-ID: <Pine.LNX.4.42.0212060948250.7121-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have an issue that I've been trying to track down for some time, and I
was hoping that someone might be able to provide me with a definitive
awnser.

I work in a company with a large number of Linux machine deployed all
around the country, and in some of the machines we've been seeing the
following error:

Uhhuh. NMI received. Dazed and confused, but trying to continue
You probably have a hardware problem with your RAM chips

Now, from what I've read about this error, it is caused by the memory
detecting a parity error in the actual RAM chips, and reporting it to the
OS.  However, some of the people within the company who handle the
replacement of hardware are convinced that it might be something simpler
in some of the cases.  Perhaps the RAM chip isn't fully seated, or the
machine just needs a reboot.

Due to the number of machines and their locations, running memtest86 on
them isn't exactly feasible.

Is there anything besides failing hardware that could be the cause of this
error?  Also, how serious is this error?  Some of the machines reporting
this error have had problems with programs crashing, while others seem to
run fine.

Any input or resources you could point me at would be appreciated.

Greg Boyce

