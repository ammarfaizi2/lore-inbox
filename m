Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUHFQ2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUHFQ2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUHFQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:24:47 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:5114 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S268155AbUHFQYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:24:15 -0400
Message-Id: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
In-reply-to: <4112E2D7.9020606@pobox.com> 
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brett Russ <russb@emc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Aug 2004 11:23:41 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Aug 2004 21:45:59 EDT, Jeff Garzik wrote:
>ATAPI works too.....  assuming your CD/DVD drive never encounters a 
>CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)

  Heh.  Where should one start looking to get this enabled?  I have to
  admit that I have given the code only a few minutes viewing.

++doug
