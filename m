Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbSKJOAI>; Sun, 10 Nov 2002 09:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSKJOAH>; Sun, 10 Nov 2002 09:00:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16544 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264868AbSKJOAH>; Sun, 10 Nov 2002 09:00:07 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <m1k7jmcgo5.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
	<m1of8ycihs.fsf@frodo.biederman.org>
	<1036894347.22173.6.camel@irongate.swansea.linux.org.uk> 
	<m1k7jmcgo5.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 14:30:41 +0000
Message-Id: <1036938641.1005.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 02:16, Eric W. Biederman wrote:
> To use kmapped memory I need to setup a page table to do the final copy.
> And to setup a page table I need to know where the memory is going to be copied
> to.

And ?

I find it hard to believe you can't drive an MMU if you can write code
that boots one Linux from another

