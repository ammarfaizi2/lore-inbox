Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVCISv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVCISv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVCISgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:36:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51154 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262166AbVCISey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:34:54 -0500
Date: Wed, 9 Mar 2005 11:20:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andi Kleen <ak@muc.de>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309142029.GC15110@logos.cnet>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm35w3am.fsf@muc.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  - Security patches will be accepted into the -stable tree directly from
> >    the security kernel team, and not go through the normal review cycle.
> >    Contact the kernel security team for more details on this procedure.
> 
> This also sounds like a bad rule. How come the security team has more
> competence to review patches than the subsystem maintainers?  I can
> see the point of overruling maintainers on security issues when they
> are not responsive, but if they are I think the should be still the
> main point of contact.

The security team is going to work with the subsystem maintainers,
not overrule them.

That would be indeed insane.
