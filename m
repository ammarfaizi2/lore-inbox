Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSA1UyM>; Mon, 28 Jan 2002 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSA1UyC>; Mon, 28 Jan 2002 15:54:02 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:11648 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S285829AbSA1Uxs>;
	Mon, 28 Jan 2002 15:53:48 -0500
Date: Mon, 28 Jan 2002 15:53:48 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Hassani <hassani@its.caltech.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <E16VIKU-0001f7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0201281551250.2376-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Alan Cox wrote:

> Im still not convinced touching the register on the 266 chipset at 0x95 is
> correct. I now have several reports of boxes that only work if you leave it
> alone
>
> Alan
>

Hmm.  What do you recommend?  I remember seeing a spec sheet and register
0x95 was the memory write queue timer.. but I could have dreamed it..

Anyone know what register 0x95 does?



