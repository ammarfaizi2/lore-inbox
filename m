Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265892AbSKBIEh>; Sat, 2 Nov 2002 03:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265893AbSKBIEh>; Sat, 2 Nov 2002 03:04:37 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:56331 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S265892AbSKBIEg>; Sat, 2 Nov 2002 03:04:36 -0500
Date: Sat, 2 Nov 2002 19:10:58 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Niels Provos <provos@citi.umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: cryptographic acceleration [Re: What's left over.]
In-Reply-To: <20021102070944.GR15875@citi.citi.umich.edu>
Message-ID: <Mutt.LNX.4.44.0211021857590.31595-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Niels Provos wrote:

> On the other hand, there are some Ethernet cards that support inline
> encryption so that not additional bus bandwidth is required to do both
> public and symmetric key cryptography.

And this is precisely the case for which we have no detailed documentation 
at this stage.  Hardware which does this includes the Intel PRO/100S and 
3Com 3CR990.

Any assistance from vendors in getting documentation on the crypto aspects 
of cards would be highly appreciated.


- James
-- 
James Morris
<jmorris@intercode.com.au>


