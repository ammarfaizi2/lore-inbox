Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSDDMdq>; Thu, 4 Apr 2002 07:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312290AbSDDMdh>; Thu, 4 Apr 2002 07:33:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:54000 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312253AbSDDMd0>; Thu, 4 Apr 2002 07:33:26 -0500
Date: Thu, 4 Apr 2002 14:31:48 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet>
Message-ID: <Pine.NEB.4.44.0204041423450.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Tigran Aivazian wrote:

>...
> sense, wrong. Namely, in the sense that it is inconsistent with the
> similar situation in the case of libraries or even system calls. I don't
>...

The COPYING file of Linux contains an explicit permission to use 'kernel
services by normal system calls' and that this 'does *not* fall under the
heading of "derived work"'. As stated in my previous mail in this thread
I'm still wondering where the allowance for binary-only modules to link
with the kernel is hidden.

> Regards,
> Tigran

cu
Adrian






