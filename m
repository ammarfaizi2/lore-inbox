Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWFHMyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWFHMyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWFHMyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:54:24 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27624 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964825AbWFHMyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:54:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-mm1
Date: Thu, 8 Jun 2006 14:54:42 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl> <20060607221142.GB6287@elte.hu>
In-Reply-To: <20060607221142.GB6287@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081454.42809.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 00:11, Ingo Molnar wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Wednesday 07 June 2006 19:47, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> > > 
> > > - Many more lockdep updates
> > 
> > Well, I've got this one (Asus L5D, x86_64 kernel):
> 
> could you try the current lock validator combo patch from:
> 
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm1.patch
> 
> does that fix this for you?

Yes, it does.

Thanks,
Rafael
