Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbTC0Xli>; Thu, 27 Mar 2003 18:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbTC0Xli>; Thu, 27 Mar 2003 18:41:38 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:14502 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261605AbTC0Xlf>; Thu, 27 Mar 2003 18:41:35 -0500
Date: Thu, 27 Mar 2003 18:47:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: config options for PS/2 kbd and USB mouse?
Message-ID: <Pine.LNX.4.44.0303271841350.1387-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i have a dell inspiron 8100 laptop on which some of the keys
are starting to misbehave, so to get around this, until i get
the chance to send it back to dell, i attached:

  1) optical logitech USB mouse
  2) dirt-cheap PS/2 keyboard

under red hat 2.4.18-4 kernel, everything works fine -- with the
current configuration, i can use either the laptop keyboard or the
external PS/2 keyboard at the same time.

i managed to boot the new 2.5.66 kernel on this box, but while the
system boots fully, neither keyboard seems to be recognized.
i thought i selected all of the necessary options under input
devices and so on, but both keyboards are stone dead.  (and,
because of that, it's kind of hard to tell if the mouse is
doing anything either, but i'll deal with one problem at a 
time.)

are there new options i should be looking at to support a
PS/2 keyboard on this laptop?  i've selected pretty much all
of the options i thought i needed, but no results so far.

any advice appreciated.

rday

