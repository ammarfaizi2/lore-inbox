Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVAJVJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVAJVJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAJVJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:09:31 -0500
Received: from colin2.muc.de ([193.149.48.15]:19728 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262473AbVAJVIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:08:31 -0500
Date: 10 Jan 2005 22:08:30 +0100
Date: Mon, 10 Jan 2005 22:08:30 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
Message-ID: <20050110210830.GA36174@muc.de>
References: <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net> <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net> <1105278618.12054.37.camel@localhost.localdomain> <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com> <1105361337.12054.66.camel@localhost.localdomain> <m1fz196o39.fsf@muc.de> <1105386921.12004.126.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105386921.12004.126.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 07:55:22PM +0000, Alan Cox wrote:
> On Llu, 2005-01-10 at 20:11, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > I haven't seen a real request from someone who requires 1GB, but needs
> > to use more than 96MB (16MB GFP_DMA + 64-128MB softiommu/amd iommu memory) 
> 
> Some bm4400 users report this problem.

I would assume 64-96MB is enough for a bcm4400.

-Andi
