Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270624AbRHSQkW>; Sun, 19 Aug 2001 12:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRHSQkL>; Sun, 19 Aug 2001 12:40:11 -0400
Received: from mail.mesatop.com ([208.164.122.9]:3597 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S270617AbRHSQjy>;
	Sun, 19 Aug 2001 12:39:54 -0400
Message-Id: <200108191640.f7JGe6e26578@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Swap size for a machine with 2GB of memory
Date: Sun, 19 Aug 2001 10:39:48 -0400
X-Mailer: KMail [version 1.2.3]
Cc: gars@lanm-pc.com
In-Reply-To: <20010819024233.A26916@thyrsus.com>
In-Reply-To: <20010819024233.A26916@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 August 2001 02:42 am, Eric S. Raymond wrote:
> The Red Hat installation manual claims that the size of the swap partition
> should be twice the size of physical memory, but no more than 128MB.
----------------------------------------------------------------^^^^^
For the benefit of anyone finding this in the kernel archives and any
future Linux technical historians, this 128MB swap partition limit was
fixed by a patch submitted by Stephen C. Tweedie on 9 Jul 1998, and which 
appeared in 2.1.109 on 20 Jul 1998.

Steven
