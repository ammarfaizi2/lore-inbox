Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWF1Rtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWF1Rtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWF1Rtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:49:49 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:49076 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1751511AbWF1Rts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:49:48 -0400
Message-ID: <44A2C130.7060904@kernel-api.org>
Date: Wed, 28 Jun 2006 19:49:36 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: ptesarik@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org>	<1151495225.8127.68.camel@elijah.suse.cz>	<44A2749D.7030705@kernel-api.org>	<20060628090950.c1862a9e.rdunlap@xenotime.net>	<1151511215.8127.74.camel@elijah.suse.cz>	<20060628093619.6b9f2b8c.rdunlap@xenotime.net>	<44A2B123.7000304@kernel-api.org> <20060628095045.7522ec7f.rdunlap@xenotime.net>
In-Reply-To: <20060628095045.7522ec7f.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> OK, I believed Petr when he stated that, I just wanted to get my
> head screwed on straight.  So its the blank line between
> 
>  */
> and
> struct sk_buff {
> ?

Exactly.


> 
> I don't think the kernel-doc rules cover that case, but
> scripts/kernel-doc handles it, so the Doxygen parser should handle
> it IMO. 
> 

Doxygen should handle it but doesn't do so.

Lukas

