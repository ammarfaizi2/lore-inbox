Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKWODK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKWODK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKWODK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:03:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15507 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750806AbVKWODJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:03:09 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, Avi Kivity <avi@argo.co.il>,
       Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123105149.GA12400@ime.usp.br>
References: <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	 <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org>
	 <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org>
	 <438349F4.2080405@argo.co.il> <20051122165638.GE32684@havoc.gtf.org>
	 <20051123105149.GA12400@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 23 Nov 2005 14:29:35 +0000
Message-Id: <1132756175.7268.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 08:51 -0200, Rogério Brito wrote:
> VIA? SiS? What manufacturers are really getting along with Open Source
> drivers (even if their products are not for "3l33t" users/gamers)?

Possibly the best x86 one right now for docs, help and the like is AMD.
Intel varies by which bit of Intel but publish a lot of stuff including
errata which many vendors are reluctant to publish.

I've personally had good results with people at VIA although it can be
quite variable and it is (as often the case) about the right groups of
people trusting each other personally rather than public everything, ALi
(likewise) although no experience with SiS. 

With a lot of the vendors it really is about good direct relationships.
They need to know who to talk to, that the person concerned on the open
source end is trustworthy and relevant to the community. Most don't work
on the kind of margins that let them interact with the entire world that
way.

A lot of vendors do help and if you look over the kernel you will see
many vendor written drivers and a fair number of 'written using vendor
driver as a reference' drivers.


