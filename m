Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWH2LcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWH2LcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWH2LcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:32:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:59592 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964930AbWH2LcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:32:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IbPRMAlgUYyRmALC5FnEZe0eluljnEgTRNYDPqf49k3cytCVfRxUHiNWEQMn9wWxUgBrNFHOJ9HNTTIe+xyk5L9gPFDa/IdQ4Maq2agdBGG563NDTz+y6wl1GPb8r8heFVKgCOlv+G0GgCSs2nXIvDNw44SzLiEct63CU1tFa5o=
Message-ID: <69304d110608290432m4ada1fccy9fba476c7a97a7fb@mail.gmail.com>
Date: Tue, 29 Aug 2006 13:32:22 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>, Niklaus <niklaus@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SDRAM or DDRAM in linux
In-Reply-To: <20060829104315.GB4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com>
	 <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
	 <20060829080024.GA917@rhlx01.fht-esslingen.de>
	 <20060829104315.GB4187@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Tue, Aug 29, 2006 at 10:00:24AM +0200, Andreas Mohr wrote:
> > > 2) Can both SDRAM and DDRAM be present at a time in the same
> > > motherboard. I mean can i have 256MB of SDRAM chip and a 256 MB of
> > > DDRAM on the same motherboard.
> > >
> > > If yes what are the conditions.
> >
> > Yes, iff the board has both DDRAM and SDRAM slots (ECS K7S5A comes to mind,
> > most popularly).
>
> Er, I owned a K7S5A, and as best as I can remember the manual was pretty
> explicit that you could have one, or the other, but _not_ both at the
> same time. :)
>

I have a K7S5A working and when I plug a DDRAM, the SDRAM is ignored.
