Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRKVSqN>; Thu, 22 Nov 2001 13:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281277AbRKVSqE>; Thu, 22 Nov 2001 13:46:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281239AbRKVSpu>; Thu, 22 Nov 2001 13:45:50 -0500
Date: Thu, 22 Nov 2001 10:40:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix SCSI non-blocksize reads
In-Reply-To: <20011122102054.A11961@codepoet.org>
Message-ID: <Pine.LNX.4.33.0111221039530.1479-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Erik Andersen wrote:
>
> Would you like a patch that also fixes all the other SCSI drivers
> to use block_size() then, so they will be consistent?

Eventually yes, although right now I'd like to have the minimal fix.

		Linus

