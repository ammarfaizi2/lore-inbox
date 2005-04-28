Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVD1IHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVD1IHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVD1IHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:07:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261594AbVD1IHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:07:11 -0400
Date: Thu, 28 Apr 2005 04:06:46 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [RFC][PATCH 0/4] AES assembler implementation for x86_64
In-Reply-To: <1114671628.13134.4.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0504280406160.21859-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Fruhwirth Clemens wrote:

> > If anybody has a better assembler solution for x86_64 I'll be pleased to
> > have my code replaced with the better solution.
> 
> http://loop-aes.sourceforge.net/loop-AES-latest.tar.bz2 aes-amd64.S

Jari's code cannot be included in the kernel.


- James
-- 
James Morris
<jmorris@redhat.com>


