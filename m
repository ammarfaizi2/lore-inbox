Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSGHGC2>; Mon, 8 Jul 2002 02:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGHGC1>; Mon, 8 Jul 2002 02:02:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:8711 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S316794AbSGHGC1>; Mon, 8 Jul 2002 02:02:27 -0400
Date: Mon, 8 Jul 2002 16:04:48 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andi Kleen <ak@suse.de>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] simplify networking fcntl
In-Reply-To: <p73d6tzwkap.fsf@oldwotan.suse.de>
Message-ID: <Mutt.LNX.4.44.0207081556460.25873-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jul 2002, Andi Kleen wrote:

> 
> I believe James Morris did this (clean up network fcntl) already in a more 
> complex patchkit that also cleans up the SIGIO/SIGURG sending. 
> 

This is almost ready, I just need to complete a couple of higher priority 
tasks before incorporating some further suggestions and finalizing the 
patch (may be a week or so until I can get back to it).


- James
-- 
James Morris
<jmorris@intercode.com.au>



