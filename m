Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUHBOnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUHBOnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUHBOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:42:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266574AbUHBOko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:40:44 -0400
Date: Mon, 2 Aug 2004 10:39:51 -0400
From: Alan Cox <alan@redhat.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: PATCH: Fix HPT366 crash and support HPT372N
Message-ID: <20040802143951.GA15610@devserv.devel.redhat.com>
References: <20040801001522.GA13954@devserv.devel.redhat.com> <20040802141131.GA2716@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802141131.GA2716@mea-ext.zmailer.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 05:11:31PM +0300, Matti Aarnio wrote:
> I have been wondering about HPT37x in Fedora Core (development) kernel
> called  kernel-smp-2.6.7-1.501.i686.  It doesn't find one of the cards
> attached to a HPT372A card that I have.
> 
> I tried also to boot with a bit older kernels: 2.6.3, 2.6.5 do work just 
> fine (except of 2.6.5 barfs the keyboard..). 

Probably unrelated. I'd ask Arjan or see if it depends on the compiler or
some other horror

This patch is unrelated to 372A

