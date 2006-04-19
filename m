Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWDSAEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWDSAEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDSAEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:04:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750907AbWDSAEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:04:06 -0400
Date: Tue, 18 Apr 2006 17:04:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: art <art@usfltd.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: is this GPL v2 violation - konica-minolta or EFI ?
In-Reply-To: <200604181824.AA3736200@usfltd.com>
Message-ID: <Pine.LNX.4.64.0604181653080.3701@g5.osdl.org>
References: <200604181824.AA3736200@usfltd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Apr 2006, art wrote:
>
> is this GPL v2 violation - konica-minolta or EFI ?
> 
> http://www.konicaminolta.us
> http://www.efi.com/
> 
> product: option for konica-minolta bizhub c351
> IC-402 Embedded Fiery Print Controller
> 
> product: EFI - Fiery System 6e system 6e X3e CONTROLLER SOLUTIONS
> 
> product: EFI - PrintMe

Probably not, but it's hard to tell. 

When they sell you the system, they have to tell you how to get sources if 
those things run Linux, but they don't actually have to make the sources 
available otherwise.

(I didn't look the things up, but it's also pretty unlikely that they'd 
have a custom kernel on them. I don't see why they should - at least the 
IC-402 thing seems to be basically just an embedded PC. So I suspect they 
have little incentive to keep anything secret).

		Linus
