Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262867AbRE0WtR>; Sun, 27 May 2001 18:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbRE0WtI>; Sun, 27 May 2001 18:49:08 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:36749 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S262867AbRE0Ws6>;
	Sun, 27 May 2001 18:48:58 -0400
Organization: 
Date: Mon, 28 May 2001 01:48:40 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: Matrox G400 Dualhead
Message-ID: <Pine.GSO.4.33.0105280144330.23684-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a serious problem when usind the second head of my Matrox with the
matroxfb driver.If I login to /dev/tty0 (fb0) and then to /dev/tty6(fb1)
and make fb1 to scroll,if I switch back to /dev/tty0 and make fb0 to
scroll while fb1 is still scrolling I get a segmentation fault.Also
sometimes I get a message like this:
INIT:Id "1" respawning too fast disabled for 5 minutes.
Can anyone help me ?

		Mythos


