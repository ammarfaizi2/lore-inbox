Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSLJPir>; Tue, 10 Dec 2002 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSLJPir>; Tue, 10 Dec 2002 10:38:47 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:1549 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261701AbSLJPir>; Tue, 10 Dec 2002 10:38:47 -0500
Date: Wed, 11 Dec 2002 02:46:11 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 networking, NET_BH latency
In-Reply-To: <20021210153134.GB23479@laguna.alcove-fr>
Message-ID: <Mutt.LNX.4.44.0212110245180.1678-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Stelian Pop wrote:

> I experience some odd behaviour when routing some network packets
> on a 2.2(.18) kernel (with Ingo's low latency patch in case it 
> matters).
> 
> Although there are probably bugs in the modifications we made
> (a network card driver, some tweaks in the network core to deal
> with several packet priorities etc), I'm not sure the behaviour
> is directly due to a bug in our modifications or some synchronisation
> issue we overlooked.

Can you reproduce the problem with a vanilla 2.2.23 kernel?


- James
-- 
James Morris
<jmorris@intercode.com.au>


