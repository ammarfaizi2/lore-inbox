Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131179AbQK1NgO>; Tue, 28 Nov 2000 08:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131181AbQK1NgE>; Tue, 28 Nov 2000 08:36:04 -0500
Received: from mail.zmailer.org ([194.252.70.162]:64526 "EHLO zmailer.org")
        by vger.kernel.org with ESMTP id <S131179AbQK1Nf5>;
        Tue, 28 Nov 2000 08:35:57 -0500
Date: Tue, 28 Nov 2000 15:05:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aironet4500_cs
Message-ID: <20001128150550.O28963@mea-ext.zmailer.org>
In-Reply-To: <14882.56795.439127.291518@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14882.56795.439127.291518@somanetworks.com>; from georgn@somanetworks.com on Mon, Nov 27, 2000 at 05:19:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 05:19:07PM -0500, Georg Nikodym wrote:
> Am I foolish to expect the aironet4500_cs (and friends) to work with
> my shiny new Cisco Aironet 340 pcmcia card?

	One of my collegues is using Aironet 342 card at his Linux
	laptop with lattest PCMCIA-CS package.

	The basic card functionality is ok, but hardware crypto usage
	isn't (string/buffer overflows, and some runtime parameter
	passing stupidities) - he made some patches to get 128 bit
	crypto to work.

> If not, anybody got any helpful hints on how to get things off the
> ground?

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
