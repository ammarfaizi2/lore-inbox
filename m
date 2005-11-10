Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVKJVun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVKJVun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKJVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:50:43 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:46438 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932177AbVKJVul convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:50:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fpC9BpfCm4QEHEGwRGXBVOjGfC20/cCqGmNawLYyRJineyIs8Exr+RSZU56zaYndlJY3jJzqbm0FvoNaijh6J35KIWy8qILRn4i4TbnmjwLFJHG3Fi+vcVRpSs+EOBo9zXRGs4yCb7vJ1WW3/whKlIHAa27xzU+hd0Emci4cvlk=
Message-ID: <58cb370e0511101350j6bcac43l8d4858d4e9ba39a3@mail.gmail.com>
Date: Thu, 10 Nov 2005 22:50:40 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jochen Hein <jochen@jochen.org>
Subject: Re: [2.6.14] ATAPI DVD no longer found
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87fyq46xv3.fsf@echidna.jochen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87fyq46xv3.fsf@echidna.jochen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/05, Jochen Hein <jochen@jochen.org> wrote:
>
> Hardware is a Thinkpad R40, Debian sarge with -linus kernel.

<...>

> Somewhere between 2.6.14-rc5 and 2.6.14.1 the DVD gets lost...
> Any ideas?

Absolutely no IDE changes between  2.6.14-rc5 and 2.6.14.1.

Moreover going through 2.6.14-rc5 to 2.6.14 changelog I can't
see any patches which would be likely to blame, are you sure
that you've used identical configuration files for both kernels?

Bartlomiej
