Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbTEXO7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTEXO7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:59:19 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:27264 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id S262058AbTEXO7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:59:18 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Philippe =?iso-8859-15?q?Gramoull=E9?= <pgramoul@nerim.net>,
       Russell Coker <russell@coker.com.au>
Subject: Re: 2.4.21-rc3
Date: Sat, 24 May 2003 17:12:23 +0200
User-Agent: KMail/1.5.2
Cc: reiserfs <reiserfs-list@namesys.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200305232256.17604.russell@coker.com.au> <20030523161356.7986c5d6.pgramoul@nerim.net>
In-Reply-To: <20030523161356.7986c5d6.pgramoul@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305241712.23316.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 23. Mai 2003 16:13 schrieb Philippe Gramoullé:
> Hello Russell,
>
> On Fri, 23 May 2003 22:56:17 +1000
>
> Russell Coker <russell@coker.com.au> wrote:
>   | I've noticed that the modules ide-taskfile.o and ide-io.o depend on
>   | each other if you compile the 2.4.21-rc3 with IDE as modules.
>   |
>   | Is this a bug in the kernel or are we supposed to use a new module
>   | loader that can resolve such things?
>
> IIRC, according to Alan Cox, on LKML, IDE shouldn't even work as a module,
> well, if you value your data.
>
> So why don't you include IDE statically in your kernel ?

Because it worked for ages and do NOT since 2.4.19 or so.

I have all SCSI and need ATA/IDE only from time to time to recover bad ATA/IDE 
disks for some friends or customers.

ATA/IDE shouldn't be demanded thing in the kernel.

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

