Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTHJNTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTHJNTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:19:35 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:49164 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264030AbTHJNTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:19:34 -0400
Date: Sun, 10 Aug 2003 23:18:43 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matt Mackall <mpm@selenic.com>
cc: Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, <davem@redhat.com>
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030809173329.GU31810@waste.org>
Message-ID: <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Matt Mackall wrote:

> out. Another thing I failed to mention at 3am is that most of the
> speed increase actually comes from the following patch which wasn't in
> baseline and isn't cryptoapi-specific. So I expect the cryptoapi
> version is about 30% faster once you amortize the initialization
> stuff.
> 
> >>>>
> Remove folding step and double throughput.

Why did you remove this?


- James
-- 
James Morris
<jmorris@intercode.com.au>

