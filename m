Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSLJAfp>; Mon, 9 Dec 2002 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbSLJAfp>; Mon, 9 Dec 2002 19:35:45 -0500
Received: from codepoet.org ([166.70.99.138]:32702 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S266456AbSLJAfo>;
	Mon, 9 Dec 2002 19:35:44 -0500
Date: Mon, 9 Dec 2002 17:43:28 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Spacecake <lkml@spacecake.plus.com>, Samuel Flory <sflory@rackable.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT372 RAID controller
Message-ID: <20021210004328.GA20392@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Spacecake <lkml@spacecake.plus.com>,
	Samuel Flory <sflory@rackable.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021208123134.4be342c7.lkml@spacecake.plus.com> <3DF4E433.5010207@rackable.com> <20021209203338.32e8665f.lkml@spacecake.plus.com> <1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 10, 2002 at 12:31:47AM +0000, Alan Cox wrote:
> > Will this appear in 2.4.21?
> 
> I've sent Marcelo the base of the new IDE. Need to chase down some bits
> that got lost in the post, then after testing some fixes for portability
> that broke sparc64.

It would _sure_ be nice if there were a way to test the IDE
changes vs 2.4.20 independant of all the other -ac changes...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
