Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVAPOXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVAPOXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVAPOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:21:39 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:37174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262518AbVAPOSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 09:18:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=E4Vfy5jalXzyn1HlYs0NNb0sO7QTx2EiLg5ETwlWcM3g23LMEkQHds5kzYxie2aCEgWlyu27t35gKj5bRwflOVy77SK2D/awn2sgQrt5MZHtQNlov3+Oz4uf2wYMc5B8lnPOn/gyypASr/gqBPT9ToM9yAMRsPxYSEEz7cbOOME=
Message-ID: <8e93903b05011606183618af9a@mail.gmail.com>
Date: Sun, 16 Jan 2005 14:18:26 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: Nils Radtke <lkml@think-future.de>,
       Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: ethX interface rx errors AND RE: Promise module (old) broken
In-Reply-To: <20050116130254.6FFF744142@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050116130254.6FFF744142@service.i-think-future.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 14:02:50 +0100, Nils Radtke <lkml@think-future.de> wrote:
> 
> Thx to Nick Warne, Bernd Eckenfels (both about RX errors), Bartlomiej
> Zolnierkiewicz, Alan Pope (both about PROMISE20565) for answers and suggestions.

Mines still broken.

> With 2.6.10 (and the PCI slots swapped) the RX errors are much less AND
> the PROMISE20565 controller works (almost) out of the box.

Unfortunately I can't swap PCI slots as my promise is on the motherboard.

Cheers,
Al.
