Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSFKCxt>; Mon, 10 Jun 2002 22:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFKCxs>; Mon, 10 Jun 2002 22:53:48 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:36010 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id <S316666AbSFKCxs>;
	Mon, 10 Jun 2002 22:53:48 -0400
Subject: Locking CD tray w/o opening device
From: Nathan Neulinger <nneul@umr.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: University of Missouri - Rolla
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 10 Jun 2002 21:53:46 -0500
Message-Id: <1023764027.20599.12.camel@cessna>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a 9 month old, going on 2, in the house, I've been made painfully
aware of the need to have some way to lock the CD-ROM tray. I saw a post
about some patches way back in 1996 to enable user-space control of
this, but haven't seen much in the way of tools to control it. 

Is there any straightforward way of disabling the buttons on the CD and
locking all the time? I'm not averse to an ugly hack to 2.4.18+ source
if necessary.

Any suggestions?

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

