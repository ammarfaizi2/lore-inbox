Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbRF1WcC>; Thu, 28 Jun 2001 18:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbRF1Wbw>; Thu, 28 Jun 2001 18:31:52 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36463 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264779AbRF1Wbo>; Thu, 28 Jun 2001 18:31:44 -0400
Date: Thu, 28 Jun 2001 18:31:39 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <15163.44990.304436.360220@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, David S. Miller wrote:

> There simply is no standard API for 64-bit DAC, sorry.
>
> This isn't changing in 2.4.x, please face facts.  It simply is not
> a feature of 2.4.x, and we are well beyond feature freeze now.
>
> It is certainly changing in 2.5.x which is just around the corner.

Sorry, but that's not a good enough answer if 2.5 takes the same 2 years
that 2.3 took.  Define the API so that people can at least write their
drivers to the spec, or else suffer the consequences of people doing their
own thing.

		-ben

