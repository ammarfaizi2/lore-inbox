Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRE3QuC>; Wed, 30 May 2001 12:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbRE3Qtw>; Wed, 30 May 2001 12:49:52 -0400
Received: from [200.250.58.156] ([200.250.58.156]:7436 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261594AbRE3Qtl>; Wed, 30 May 2001 12:49:41 -0400
Date: Wed, 30 May 2001 12:08:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy NBD
In-Reply-To: <200105301639.RAA21383@gw.chygwyn.com>
Message-ID: <Pine.LNX.4.21.0105301208140.5110-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 May 2001, Steve Whitehouse wrote:

> Hi,
> 
> Attached is a patch I came up with recently to do add zerocopy support to
> NBD for writes. I'm not intending that this should go into the kernel
> before at least 2.5, I'm just sending it here in case it is useful to anyone.
> 
> I wrote it is a simple way to experiment with the new zerocopy code
> rather than in a bid to improve the efficiency NBD dramatically. I'm
> currently preparing a paper for the UKUUG Linux Conference which will
> present some results obtained with the patch and discuss it in more
> detail. The paper will be available on the web too nearer the time.

Cool. 

Are you seeing performance improvements with the patch ?
 


