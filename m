Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVLEI3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVLEI3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVLEI3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:29:34 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:54089 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932363AbVLEI3d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:29:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YAEqlc71usGKCw8liiiR+EZp+zfYPJ6Kc28Fy4VjrPg0i7GTg/um5XTwdBmHmb65VSOtP4mDvP2CyOkUGKX11wIUVL5iL5uUkc132+4SUcUSVcCRdkBIIP4iVJFajnIFwZW35cvgwemc42wnt64l05T2xxvBkDivl0f9Trfqg3w=
Message-ID: <58cb370e0512050029g2cf8714fj260b01e06a59581@mail.gmail.com>
Date: Mon, 5 Dec 2005 09:29:31 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] touch softlockup watchdog in ide_wait_not_busy
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490512021729t145291c0h8ba5b8bdb0513d9e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511291555.27202.jesper.juhl@gmail.com>
	 <9a8748490512021729t145291c0h8ba5b8bdb0513d9e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Andrew,
>
> Now that Alexander confirmed this patch fixed his problem, any reason
> it couldn't go into -mm ?

Fine with me now.

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> He gave this feedback :
> On 11/30/05, Alexander V. Inyukhin <shurick@sectorb.msk.ru> wrote:
> ...
> > It seems to work.
> > I have no BUG messages during boot with this patch.
