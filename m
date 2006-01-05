Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWAENfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAENfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWAENfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:35:45 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:15864 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbWAENfo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:35:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZ3FHxz1TR2JU7V50FMwKU/Wk85fCm6MmByCuwF8+RdUHlEuEz8sGR3NFlvnDuA4tQgFE+hqUOuk24/LWCbomwrBxxwyO1q2hQ/VLRulMvNKsAP1Yepf85deKmIuS7BRaDopEVEgFAsm7M/h8aKt24ycv1pDPhNC3YKByhJ2OBw=
Message-ID: <84144f020601050535l30f57036g4477c650081a8a55@mail.gmail.com>
Date: Thu, 5 Jan 2006 15:35:42 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: takis@issaris.org
Subject: Re: [PATCH] drivers/media: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <20060105130229.7E65F6B35@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105130229.7E65F6B35@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Panagiotis Issaris <takis@issaris.org> wrote:
> From: Panagiotis Issaris <takis@issaris.org>
>
> Conversions from kmalloc+memset to k(z|c)alloc.

Looks good to me. I assume you have made sure it compiles?

                                           Pekka
