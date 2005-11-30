Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVK3C4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVK3C4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVK3C4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:56:32 -0500
Received: from mail.suse.de ([195.135.220.2]:1962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750781AbVK3C4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:56:31 -0500
Date: Wed, 30 Nov 2005 03:56:30 +0100
From: Andi Kleen <ak@suse.de>
To: Keith Mannthey <kmannth@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
Message-ID: <20051130025630.GH19515@wotan.suse.de>
References: <20051129033102.GA5706@mea-ext.zmailer.org> <p73veybh7tj.fsf@verdi.suse.de> <20051129235304.GB5706@mea-ext.zmailer.org> <20051130003118.GZ19515@wotan.suse.de> <a762e240511291826l7c91d836i1b6c750a49ed576d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a762e240511291826l7c91d836i1b6c750a49ed576d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 06:26:28PM -0800, Keith Mannthey wrote:
> On 11/29/05, Andi Kleen <ak@suse.de> wrote:
> > > Not that those explain all that much...
> >
> > Can you send me your .config? If you have SPARSEMEM enabled can you
>  > disable it?
> 
> This looks just like the sparsemem troubles.  There is a patch around
> somwhere....  I thought a patch was being pushed into mainline but I
> guess not.

It was I think. But I still don't trust it.

-Andi
