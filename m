Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbVGOEOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbVGOEOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbVGOEOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:14:19 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:63184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263191AbVGOEOS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:14:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hekXS2ipgyly5FvotsH17SAdcwhp+YaJzpj8vz/akGs3jc/ETHJcWSoSgKZNTLKAw+gDgiYpo1jlqpTbMDPi7ujsmL1pDFiuW4Dp0cDl9YZNACFzne5W7DN3D0orYc+4eAJ9LMvuwQal+PAgSsCBTFrED6x/c5Yk+eA3d+KfYzM=
Message-ID: <2ea3fae10507142114eb5ab1@mail.gmail.com>
Date: Thu, 14 Jul 2005 21:14:16 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050715060532.5873f01b@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ea3fae10507141058c476927@mail.gmail.com>
	 <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
	 <20050714190929.GL23619@wotan.suse.de>
	 <2ea3fae1050714194649c66d7e@mail.gmail.com>
	 <20050715030518.GS23737@wotan.suse.de>
	 <2ea3fae105071420529c3e975@mail.gmail.com>
	 <20050715060532.5873f01b@basil.nowhere.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EFI support in x86-64?

Is EFI only support IA64?

Is acpi in EFI?

YH

On 7/14/05, Andi Kleen <ak@suse.de> wrote:
> On Thu, 14 Jul 2005 20:52:58 -0700
> yhlu <yinghailu@gmail.com> wrote:
> 
> > Andi,
> >
> > How do yo think about make x86-64 kernel support openfirmware interface?
> 
> I don't like it. We already have the old x86 BIOS interfaces and ACPI
> and at some point EFI. No need for more.
> 
> -Andi
>
