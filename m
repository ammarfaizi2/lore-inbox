Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVCCRHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVCCRHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVCCREc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:04:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45754 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262478AbVCCRD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:03:58 -0500
Date: Thu, 3 Mar 2005 18:03:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303170336.GL19505@suse.de>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303165533.GQ28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303165533.GQ28536@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03 2005, Chris Wright wrote:
> >  - Finally: this tree never has any history past the "last release". When
> >    a new kernel comes, the tree is frozen, and never to be touched again.
> 
> I like this definition.  The only remaining question is what determines
> a 2.6.x.y release?  One patch?  Sure if it's critical enough.  

Why should there be one? One of the things I like about this concept is
that it's just a moving tree. There could be daily snapshots like the
-bkX "releases" of Linus's tree, if there are changes from the day
before. It means (hopefully) that no one will "wait for x.y.z.2 because
that is really stable".

-- 
Jens Axboe

