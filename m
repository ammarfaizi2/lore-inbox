Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTKSQkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTKSQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:40:07 -0500
Received: from vpn-19-8.aset.psu.edu ([146.186.19.8]:22410 "EHLO
	funkmachine.cac.psu.edu") by vger.kernel.org with ESMTP
	id S263900AbTKSQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:40:04 -0500
Message-ID: <3FBB9CD3.C29D8675@psu.edu>
Date: Wed, 19 Nov 2003 11:39:47 -0500
From: Jason Holmes <jholmes@psu.edu>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19-pre3-rmap12h i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
References: <3FB3BBE0.D4D0EACC@psu.edu> <3FB3D5B1.5080904@pobox.com> <20031113153552.A20514@lists.us.dell.com> <20031119131627.A12116@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Thu, Nov 13, 2003 at 03:35:52PM -0600, Matt Domsch wrote:
> > > ewwww.
> > >
> > > I don't object to your patch, but I'm disappointed that megaraid doesn't
> > > use the normal PCI probing mechanism.
> >
> > It's on their TODO list I know.  I've been pushing for that too.
> 
> Here's a patch.  If someone who has access to the hardware could actually
> test it it would be a nice candidate for 2.6.1..

It worked for me for both a Dell PERC4 card and an Intel SRCU42X card.

Thanks,

--
Jason Holmes
