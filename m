Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273719AbRIXAOq>; Sun, 23 Sep 2001 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273720AbRIXAOg>; Sun, 23 Sep 2001 20:14:36 -0400
Received: from CPE-61-9-148-170.vic.bigpond.net.au ([61.9.148.170]:7177 "EHLO
	front.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S273719AbRIXAOc>; Sun, 23 Sep 2001 20:14:32 -0400
Date: Mon, 24 Sep 2001 10:09:42 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: dcinege@psychosis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
Message-Id: <20010924100942.0a37db8d.rusty@rustcorp.com.au>
In-Reply-To: <E15l3Qu-0005YQ-00@schizo.psychosis.com>
In-Reply-To: <E15l2tb-0004KK-00@wagner>
	<E15l3Qu-0005YQ-00@schizo.psychosis.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001 03:12:54 -0400
David Cinege <dcinege@psychosis.com> wrote:

> On Sunday 23 September 2001 2:37, Rusty Russell wrote:
> 
> Russ,
> 
> How about implementing MBS? (Bootloader module loading. IE as implmented in 
> GRUB) so we can finally have completely modular kernels?

Hi Dave,

	Why duplicate the module code in the boot loader?  Surely a tiny initrd 
or equiv is a better option here?

Rusty.
--
New mailer, beware.
