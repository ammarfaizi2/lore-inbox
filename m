Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUKSBzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUKSBzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUKSByT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:54:19 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:40459 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261225AbUKSBvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:51:10 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: rs@mmania.com (Olivier Poitrey)
Subject: Re: Kernel panic in tcp_time_to_recover with 2.6.9
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Organization: Core
In-Reply-To: <87is83qot4.fsf@ice.aspic.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CUxvH-0002vq-00@gondolin.me.apana.org.au>
Date: Fri, 19 Nov 2004 12:50:51 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Poitrey <rs@mmania.com> wrote:
> Got a kernel panic at tcp_time_to_recover+75/1d0 on two nodes

Known problem.  Fixed in 2.6.10-rc2.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
