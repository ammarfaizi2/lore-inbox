Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbRE2Cw5>; Mon, 28 May 2001 22:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbRE2Cwh>; Mon, 28 May 2001 22:52:37 -0400
Received: from mnh-1-04.mv.com ([207.22.10.36]:35085 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262017AbRE2Cwg>;
	Mon, 28 May 2001 22:52:36 -0400
Message-Id: <200105290406.XAA05975@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.42-2.4.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 May 2001 23:06:13 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.5 is available.

The network drivers have been completely redone.  If you've tried to set up 
UML networking and failed, try it again.  There's a new helper which will do 
most of the host-side setup for you.  The easiest way to get it is to install 
the RPM.  It's also available from CVS.  See http://user-mode-linux.sourceforge
.net/networking.html for all the details.

A number of other bugs have been fixed, as well.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at http://sourceforge.net/project/filelist.php?group_id
=429 and ftp://ftp.nl.linux.org/pub/uml/

				Jeff


