Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWEQBVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWEQBVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWEQBVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:21:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:50364 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932407AbWEQBVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:21:44 -0400
Message-ID: <446A7A93.7000601@zytor.com>
Date: Tue, 16 May 2006 18:21:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
References: <20060515005637.00b54560.akpm@osdl.org> <200605152037.54242.ak@suse.de> <1147719901.6623.78.camel@localhost.localdomain> <200605152111.20693.ak@suse.de> <e4b1ha$e1b$1@terminus.zytor.com> <20060517003927.GA13465@redhat.com>
In-Reply-To: <20060517003927.GA13465@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, May 15, 2006 at 04:06:18PM -0700, H. Peter Anvin wrote:
>  > Followup to:  <200605152111.20693.ak@suse.de>
>  > By author:    Andi Kleen <ak@suse.de>
>  > In newsgroup: linux.dev.kernel
>  > > 
>  > > > x86 is a legacy architecture now anyway, right? ;)
>  > > I wish everybody would agree on that @)
>  > > 
>  > 
>  > It's going to live on for a very long time, though.  Intel is still
>  > shipping some very fast 64-bit-deficient silicon.  Once that's gone,
>  > it's going to live on for decades in the embedded world.
> 
> There's also a surprising number of people still running
> their shiny new x86-64's in 32 bit mode.  (I suspect because
> they're reliant upon applications that aren't 64-bit clean
> that for whatever reason don't run in 32-bit emulation).
> 
> I'd be surprised if any of the major distros stopped shipping
> a 32-bit x86 release for several years.
> 

Yup.  In fact, I wish Fedora had the 32-bit Firefox, at least as an option.  I keep having 
to add the 32-bit repos for that reason alone :(

	-hpa
