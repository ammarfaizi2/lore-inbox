Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTFKVHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFKVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:07:04 -0400
Received: from web0.speakeasy.net ([216.254.0.11]:38835 "EHLO
	imail.speakeasy.net") by vger.kernel.org with ESMTP id S264460AbTFKVHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:07:00 -0400
Date: Wed, 11 Jun 2003 14:20:43 -0700 (PDT)
From: sydow@speakeasy.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Kernel Panic Promise driver
In-Reply-To: <1055334718.2084.10.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306111407530.18252-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I patched the kernel source with this, and recompiled the kernel. I gave 
it a shot, but the PDC20277 driver still tries to load for the 
SX6000 controller causing a kernel panic. This doesn't affect me 
currently, but it could potentially create some frustration in the future.

On 11 Jun 2003, Alan Cox wrote:

> On Mer, 2003-06-11 at 02:32, sydow@speakeasy.net wrote:
> > The output of those commands are attached. Sorry it took me awhile. My 
> > system drive gave up the ghost, and I just got it back up. Thanks for the 
> > fast response.
> 
> Thanks. Try this
> 
> 
> 

-- 

Donovan Sydow
Information Systems Lead
SPEAKEASY.net

"One World, One Web, One Program" - Microsoft promotional ad.
"Ein Volk, Ein Reich, Ein Führer" (One People, One Kingdom, One Leader) 
- Adolph Hitler.



