Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbRFXWNu>; Sun, 24 Jun 2001 18:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbRFXWNk>; Sun, 24 Jun 2001 18:13:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19209 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264830AbRFXWN3>; Sun, 24 Jun 2001 18:13:29 -0400
Subject: Re: Some experience of linux on a Laptop
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 24 Jun 2001 23:12:33 +0100 (BST)
Cc: pzycrow@hotmail.com (John Nilsson), linux-kernel@vger.kernel.org
In-Reply-To: <0106242357230C.00430@starship> from "Daniel Phillips" at Jun 24, 2001 11:57:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EI7N-0000Zr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So when you speak of being able to run on 386:es I still have problem
> > starting X on 266MHz with 32Mb mem. This should not be =)
> 
> That's true.  Usually, X by itself starts pretty fast.  Just try 'xinit', no 
> parameters.  KDE and Gnome both need to go on a diet, especially KDE.  They 

The trick if you want a good GUI environment in 32Mb is to run something like
XFce (www.xfce.org). My 32Mb test/devel box I use to prove stuff still works
sanely on non obscene computers is very happy with XFce and with BrowseX as
the web browser.

That is mostly not a kernel problem.  With XFce 3.8.3 the 32Mb box flies,
and its happy doing stuff like web browsing while playing dvd movies with the
Creative DXR2 overlay card, even though its only a Cyrix MII 233

Alan

