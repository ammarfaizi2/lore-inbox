Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVA3M0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVA3M0R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVA3M0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:26:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51364 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261692AbVA3M0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:26:14 -0500
Date: Sun, 30 Jan 2005 07:26:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Matt Mackall <mpm@selenic.com>
cc: Fruhwirth Clemens <clemens-dated-1107431870.41eb@endorphin.org>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/04] Add LRW
In-Reply-To: <20050130000221.GA2955@waste.org>
Message-ID: <Xine.LNX.4.44.0501300720390.20890-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005, Matt Mackall wrote:

> On Mon, Jan 24, 2005 at 12:57:50PM +0100, Fruhwirth Clemens wrote:
> > This is the core of my LRW patch. Added test vectors.
> > http://grouper.ieee.org/groups/1619/email/pdf00017.pdf
> 
> Please include a URL for the standard at the top of the LRW code and
> next to the test vectors. I had to search around a fair bit for decent
> background material, would be helpful to a couple other references as
> well.

Something useful if you haven't seen it yet is the tweakable block cipher
paper http://www.cs.berkeley.edu/~daw/papers/tweak-crypto02.pdf

(Pointers to any critique of the system would be appreciated).


- James
-- 
James Morris
<jmorris@redhat.com>


