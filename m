Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVFVXg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVFVXg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFVXgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:36:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262599AbVFVXdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:33:12 -0400
Date: Wed, 22 Jun 2005 16:32:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Carsten Otte <cotte.de@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050622233256.GC9153@shell0.pdx.osdl.net>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <20050621132204.1b57b6ba.akpm@osdl.org> <5c77e707050621142841ad3225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c77e707050621142841ad3225@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Carsten Otte (cotte.de@gmail.com) wrote:
> On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> > > and indeed vendors ARE shipping
> > > other crashdump methods.
> > 
> > Which ones?
> For 390, we ship standalone bootable crashdump tools with both sles
> and rhel. As for kexec, I'd like to see a kexec based 390 bootloader
> in the future which would be more flexible then our current one. So
> I'd like to vote for merging kexec/kdump.

Xen is making similar noises w.r.t. using kexec for flexible bootloader.

thanks,
-chris
