Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbRETARN>; Sat, 19 May 2001 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbRETARD>; Sat, 19 May 2001 20:17:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262013AbRETAQu>; Sat, 19 May 2001 20:16:50 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 20 May 2001 01:11:04 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Ben LaHaise),
        andrewm@uow.edu.au (Andrew Morton), Andries.Brouwer@cwi.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105191939480.7162-100000@weyl.math.psu.edu> from "Alexander Viro" at May 19, 2001 07:42:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151GoK-0000Xq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 20 May 2001, Ingo Oeser wrote:
> > PS: English is neither mine, nor Linus native language. Why do
> >    the English natives complain instead of us? ;-)
> 
> Because we had some experience with, erm, localized systems and for
> Alan it's most likely pure theory? ;-)

I think its important its considered. I do like the idea of a sensible ioctl
encoding (including ascii potentially) and being able to ship ioctls over the
network. 

