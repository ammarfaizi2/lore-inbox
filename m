Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSEGLXv>; Tue, 7 May 2002 07:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSEGLXu>; Tue, 7 May 2002 07:23:50 -0400
Received: from oh-beechwood1b-122.clvhoh.adelphia.net ([24.52.88.122]:48527
	"EHLO daedalus.dynu.net") by vger.kernel.org with ESMTP
	id <S315406AbSEGLXu>; Tue, 7 May 2002 07:23:50 -0400
Subject: Re: Can't Burn CDR's On 2.4.19pre8
From: Nox <nox@daedalus.dynu.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020507044708.GA31888@mail-infomine.ucr.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 May 2002 07:22:08 -0500
Message-Id: <1020774128.13310.10.camel@Daedalus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm getting the same problem, thought it may be my new burner, i have a
log of the attempted burn and my kernel config at
http://daedalus.dynu.net:81 The error is almost the same thing, however
sometimes I tend to get an ultra/dma 33 error. Disabling DMA on
everything except disks in kernel config had no effect on that. This
error is not random however it occurs after 63488 bytes every time. This
is a brand new Teac 40x drive on a Abit VH6T which has a VIA IDE
Controller, its the only device on its channel and it reads fine. I'd
appreciate any input on this.

Ilya Kogan
