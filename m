Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbRGEXu7>; Thu, 5 Jul 2001 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbRGEXut>; Thu, 5 Jul 2001 19:50:49 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:22391 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265593AbRGEXuh>; Thu, 5 Jul 2001 19:50:37 -0400
Date: Thu, 5 Jul 2001 19:50:10 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <15172.64662.696505.761486@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107051949510.1702-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, David S. Miller wrote:

> And this still leaves the 64-bit dma_addr_t overhead issue.

Huh?  It's a config option, just like blkoff_t.

		-ben

