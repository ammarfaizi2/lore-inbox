Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVFWNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVFWNNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVFWNND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:13:03 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:18595 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261934AbVFWNKZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:10:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lyRLgwHzjcrO6kw+AV0yF197JGvug3bCpZS/azzdNu6IDwOONJwY8mbBpiFScWZBjaOQhu2m5ohEuhcUo+A49BMgLPk4Sn7NhD/JMpHRR+iqb6B9vELmsWBaxhIE+QvPfBDZoeRluoG484C3qTR1rfAy02+nj7BcC4Bl9vRK1S8=
Message-ID: <5c77e70705062306044e1c411f@mail.gmail.com>
Date: Thu, 23 Jun 2005 15:04:04 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050622233256.GC9153@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <20050621132204.1b57b6ba.akpm@osdl.org>
	 <5c77e707050621142841ad3225@mail.gmail.com>
	 <20050622233256.GC9153@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Chris Wright <chrisw@osdl.org> wrote:
> * Carsten Otte (cotte.de@gmail.com) wrote:
> > For 390, we ship standalone bootable crashdump tools with both sles
> > and rhel. As for kexec, I'd like to see a kexec based 390 bootloader
> > in the future which would be more flexible then our current one. So
> > I'd like to vote for merging kexec/kdump.
> 
> Xen is making similar noises w.r.t. using kexec for flexible bootloader.

Oh cool, then we should look at what they're doing instead of reinventing
the wheel. Any pointer we can follow, or person we would contact?
