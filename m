Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133089AbRDRLnr>; Wed, 18 Apr 2001 07:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133090AbRDRLnh>; Wed, 18 Apr 2001 07:43:37 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:19214 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S133089AbRDRLn3>; Wed, 18 Apr 2001 07:43:29 -0400
Date: Wed, 18 Apr 2001 12:32:09 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: IonBadulescu <ionut@moisil.cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <200104181025.f3IAP3p10344@gonzales.dev.hydraweb.com>
Message-ID: <Pine.LNX.4.21.0104181227420.4446-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, IonBadulescu wrote:

> use vanilla 2.4.x, you can simply copy drivers/net/starfire.c from the -ac
> tree.

I can't use 2.4 kernels ATM because they don't boot (at all) on Cobalt
hardware for some reason - when I've got chance I'll look into it and try
and fix the 2.4 kernels so they work on Cobalt kit, but ATM it's fairly
low on my todo list ...

Anyway, it wasn't me who wanted to use the starfire driver :)

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


