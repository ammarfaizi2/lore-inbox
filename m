Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132863AbRDQXzS>; Tue, 17 Apr 2001 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132866AbRDQXy6>; Tue, 17 Apr 2001 19:54:58 -0400
Received: from www.teaparty.net ([216.235.253.180]:23301 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132863AbRDQXyu>;
	Tue, 17 Apr 2001 19:54:50 -0400
Date: Wed, 18 Apr 2001 00:54:33 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Subba Rao <subba9@home.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 2940 and Linux 2.2.19
In-Reply-To: <20010417194558.A10678@home.com>
Message-ID: <Pine.LNX.4.10.10104180048160.14484-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Subba Rao wrote:

> I am trying to configure and install linux kernel 2.2.19. This system has
> a Adaptec 2940 SCSI adapter. I have enabled SCSI support kernel configuration

I think you want the aic7xxx driver - istr the aha2940 cards are actually
aic789x chipsets. [Manufacturer naming schemes, you gotta love 'em.]

-- 
"As you point out, EFAULT situations are `undefined' which means the
machine is entitled to grow wings an launch itself towards the sun..."
 -- Chris Wedgwood on the linux-kernel mailing list

