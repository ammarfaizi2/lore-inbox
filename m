Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbRF1WYl>; Thu, 28 Jun 2001 18:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbRF1WYb>; Thu, 28 Jun 2001 18:24:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:47980 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264745AbRF1WYW>; Thu, 28 Jun 2001 18:24:22 -0400
Date: Thu, 28 Jun 2001 18:24:16 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <15163.43319.82354.562310@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106281823000.32276-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, David S. Miller wrote:

> Please note that this is nonstandard and undocumented behavior.
>
> This is not a supported API at all, and the way 64-bit DMA will
> eventually be done across all platforms is likely to be different.

Well, what is the standard API to use?  All these 64 bit cards in my
machine really make that 95% cpu usage in bounce buffer copying rather
depressing.

		-ben

