Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263237AbTCNEAK>; Thu, 13 Mar 2003 23:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbTCNEAK>; Thu, 13 Mar 2003 23:00:10 -0500
Received: from toq5-srv.bellnexxia.net ([209.226.175.27]:36329 "EHLO
	toq5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263237AbTCNEAJ>; Thu, 13 Mar 2003 23:00:09 -0500
Subject: 2.5.64-mm>1 Problems starting gnome?
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047613046.2267.97.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 22:37:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

I am having problems starting gnome in the 2.5.64-mmX (X>1). 2.5.64 and
2.5.64-mm1 work ok, 2.5.64-mm2 doesn't compile for me and the more
recent -mm don't work.

The problem is that gnome never fully gets started, it gets a variable
way through starting and then gnome slows down and dies. Shortly after
the system eventually becomes useless. Sometimes the background doesn't
even make it up, sometimes the panel almost makes it up. Sometimes I can
switch vts and get a few commands off but besides finding a few gnome
processes in the D state, I didn't see any thing. Got any suggestions on
what to look at here? This is a athlon, IDE, bttv, 3com system.

Here are those D procs (edited for readability)

shane     2009  0.0  0.5  6196 1996 ? D    21:14   0:00 gnome-smproxy
shane     2014  0.0  0.8  5720 3272 ? D    21:14   0:00 /usr/bin/sawfish
shane     2024  0.0  1.0  8884 3972 ? D    21:14   0:00
bonobo-moniker-archiver
shane     2037  0.0  0.6  6744 2584 ? D    21:14   0:00 gmix -i
shane     2043  0.0  0.4  4048 1644 ? D    21:14   0:00 xscreensaver
shane     2051  0.0  1.1 17300 4336 ? D    21:14   0:00 nautilus
shane     2055  0.0  0.8  7972 3452 ? D    21:14   0:00 panel


Shane (who wants to try the faster mozilla load :)

