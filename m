Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbRF1NDX>; Thu, 28 Jun 2001 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265709AbRF1NDD>; Thu, 28 Jun 2001 09:03:03 -0400
Received: from jet.caldera.de ([212.34.180.34]:58884 "EHLO jet.caldera.de")
	by vger.kernel.org with ESMTP id <S265697AbRF1NDB>;
	Thu, 28 Jun 2001 09:03:01 -0400
Date: Thu, 28 Jun 2001 15:02:54 +0200
Message-Id: <200106281302.f5SD2sO02107@jet.caldera.de>
From: Marcus Meissner <mm@jet.caldera.de>
To: alad@hss.hns.com, linux-kernel@vger.kernel.org
Subject: Re: Why we need LDT at all in 2.2 kernels ??
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <65256A79.0038FC3A.00@sandesh.hss.hns.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.3-ac14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <65256A79.0038FC3A.00@sandesh.hss.hns.com> you wrote:
> Hi,
>      In 2.2 kernel do we really need its own LDT (not default_ldt) for every
> process (no mm sharing) ??

> In what circumstances a process may need its own LDT ??

When using the Windows Emulator WINE and related projects (WordPerfect 2000)
for instance.

Ciao, Marcus
