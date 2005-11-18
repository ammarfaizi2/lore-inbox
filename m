Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbVKRJFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbVKRJFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVKRJFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:05:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030590AbVKRJFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:05:18 -0500
Date: Fri, 18 Nov 2005 01:04:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2
Message-Id: <20051118010449.4ecc9c1d.akpm@osdl.org>
In-Reply-To: <40f323d00511180056i5bafa5c3qffbd3b774b499ac4@mail.gmail.com>
References: <20051117234645.4128c664.akpm@osdl.org>
	<40f323d00511180056i5bafa5c3qffbd3b774b499ac4@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <benoit.boissinot@ens-lyon.fr> wrote:
>
> On 11/18/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/
> >
> >
> > - I'm releasing this so that Hugh's MM rework can get a spin.
> >
> >   Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
> >   (device drivers malfunctioning, obscure userspace hardware-poking
> >   applications stopped working, etc) please test.
> >
> >   We'd especially like testing of the graphics DRM drivers across as many
> >   card types as poss.
> >
> I tried running neverball and had "bad page state".

OK, thanks for that.

> dmesg and lspci -v attached

The attachments are empty.   Can you resend the dmesg one please?
