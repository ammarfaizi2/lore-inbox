Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRIQSm7>; Mon, 17 Sep 2001 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272048AbRIQSmt>; Mon, 17 Sep 2001 14:42:49 -0400
Received: from [213.96.124.18] ([213.96.124.18]:26347 "HELO dardhal")
	by vger.kernel.org with SMTP id <S271995AbRIQSmh>;
	Mon, 17 Sep 2001 14:42:37 -0400
Date: Mon, 17 Sep 2001 20:44:52 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: multiply mounting filesystem
Message-ID: <20010917204452.C1315@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA5BE90.29409.43AC7B@localhost> <Pine.GSO.4.21.0109170440050.20053-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.21.0109170440050.20053-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 17 September 2001, at 04:40:21 -0400,
Alexander Viro wrote:

> 
> 
> On Mon, 17 Sep 2001, Ulrich Windl wrote:
> 
> > complained. I'm very much afraid this could corrupt the filesystem. Or 
> > is Linux really smart enough to handle the case?  
> 
> Yes.
> 
And what about union mounts ?. When read "The magic world of Linux kernel
2.4" it appears that such feature was already present on 2.4.x kernels,
but I've seen nothing else about it so far.

Is it already usable, or is something still being worked on ?

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

