Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSAIOsN>; Wed, 9 Jan 2002 09:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSAIOsB>; Wed, 9 Jan 2002 09:48:01 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:32714 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S286942AbSAIOrv>; Wed, 9 Jan 2002 09:47:51 -0500
Date: Wed, 9 Jan 2002 06:47:57 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Daniel Tuijnman <daniel@ATComputing.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Memory management problems in 2.4.16
In-Reply-To: <20020109143434.A20955@ATComputing.nl>
Message-ID: <Pine.LNX.4.33.0201090640080.13260-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Daniel Tuijnman wrote:

> I installed a 2.4.16 kernel on a 486DX2-50 machine with 8MB memory and
> 24MB swap and got insurmountable problems.

[snip]

> It seems to me that something definitely is wrong with the kernel's
> memory management.

Well ... maybe *in theory* 2.4.16 should work on a machine with that
little RAM but I'd say in practice Linux has simply outgrown your
machine. Have you tried any other 2.4 kernels, say, before 2.4.10 when
the VM changed?  Have you considered going to a garage sale and spending
the local equivalent of $25 or $30 US for a more powerful computer?

--
M. Edward "Now if I could get Linux to run on a Tandy 200" Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

If they named a street after Picabo Street, would it be called Picabo
Street, Street Street or Picabo Street Street?

