Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTFGTEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTFGTEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:04:25 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:39655 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263398AbTFGTEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:04:24 -0400
Message-ID: <20030607191903.32603.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lars Unin" <lars_unin@linuxmail.org>
To: james@stev.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 08 Jun 2003 03:19:03 +0800
Subject: Re: What are .s files in arch/i386/boot [I think thats Linus,
    er.. hey Linus!]
X-Originating-Ip: 213.120.11.243
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: James Stevenson <james@stev.org>
Date: Sat, 7 Jun 2003 21:05:42 +0100 (BST)
To: Lars Unin <lars_unin@linuxmail.org>
Subject: Re: What are .s files in arch/i386/boot

> 
> > > > What are .s files in arch/i386/boot, are they c sources of some sort?
> > > > Where can I find the specifications documents they were made from? 
> > > 
> > > There are not c files.
> > > They are assembler files
> > > 
> > > Try running gcc on a c file with the -S option
> > > it will generate the same then you can tweak the
> > > assembler produced to make it faster.
> > > 
> > Where can I find the .c files they were made from,
> > and the spec sheets the .c files were made from? 
> 
> You would have to find the original author of the person
> who tweaks the assembler in the .s file chances are the .c
> file is long gone though.
> 
> Why do all .c files have to be generated from a spec sheet ?
I think Linus is the author, and he would have got the information
from somewhere, we just have to ask him where he got it from...

Err... Linus? Are you there?
Linus?
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
