Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSAWKeX>; Wed, 23 Jan 2002 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSAWKeN>; Wed, 23 Jan 2002 05:34:13 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:34842 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S289772AbSAWKd4>;
	Wed, 23 Jan 2002 05:33:56 -0500
Message-Id: <m16TKj3-02103JC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: umounting
Date: Wed, 23 Jan 2002 11:33:52 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Samuel Maftoul <maftoul@esrf.fr>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200201222210.g0MMANwH001411@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201222210.g0MMANwH001411@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, the solution is - teach your users to unmount disks before leaving,
> > or mount them in synchronous mode - but I am not sure, whether VFAT
> > supports that and it is a performance hog too.
>
> Better use mtools. No mounting required, which does screw DOSish minds.

I agree, but it probably does work only with floppies. 

Jan
