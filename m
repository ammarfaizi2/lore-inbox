Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268858AbRG0NuI>; Fri, 27 Jul 2001 09:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRG0Nt4>; Fri, 27 Jul 2001 09:49:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268857AbRG0Ntm>; Fri, 27 Jul 2001 09:49:42 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 14:49:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), haiquy@yahoo.com (Steve Kieu),
        samuelt@cervantes.dabney.caltech.edu (Sam Thompson),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <Pine.LNX.4.33.0107271542331.10602-100000@devel.blackstar.nl> from "bvermeul@devel.blackstar.nl" at Jul 27, 2001 03:47:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q7zP-0005fQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > Full data journalling will give you what you expect but at a performance hit
> > for many applications.
> 
> Do any of the other journalled filesystems for linux do this? If not, I
> guess I'll go back to ext2.

ext3 can do full data journalling, I dont know if reiserfs has an option for
it or not

Alan

