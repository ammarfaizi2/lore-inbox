Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVCDCfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVCDCfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVCDCbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:31:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:14208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbVCDC2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:28:47 -0500
Date: Thu, 3 Mar 2005 18:28:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303182820.46bd07a5.akpm@osdl.org>
In-Reply-To: <1109894511.21781.73.camel@localhost.localdomain>
References: <42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<1109894511.21781.73.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2005-03-03 at 23:17, Andrew Morton wrote:
> > Ideally, the 2.6.x.y maintainer wouldn't need any particular kernel
> > development skills - it's just patchmonkeying the things which maintainers
> > send him.
> 
> I would disagree, and I suspect anyone else who has maintained a distro
> stable kernel would likewise. It needs one or more people who know who
> to ask about stuff, are careful, have a good grounding in bug spotting,
> races, common mistakes and know roughly how all the kernel works.
> Maintainers aren't very good at it in general and they don't see
> overlaps between areas very well.
> 

That is all inappropriate activity for a 2.6.x.y tree as it is being
proposed.

Am I right?  All we're proposing here is a tree which has small fixups for
reasonably serious problems.  Almost without exception it would consist of
backports.

