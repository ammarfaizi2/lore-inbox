Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSK0BO7>; Tue, 26 Nov 2002 20:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSK0BO7>; Tue, 26 Nov 2002 20:14:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29332 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263342AbSK0BO6>; Tue, 26 Nov 2002 20:14:58 -0500
Subject: Re: 2.5.49 module problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021126193026.Q14666-100000@sorrow.ashke.com>
References: <20021126193026.Q14666-100000@sorrow.ashke.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 01:53:28 +0000
Message-Id: <1038362008.2594.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 00:40, Adam K Kirchhoff wrote:
> 
> Hello all.
> 
> Sorry to bother everyone with what is probably a stupid user error, but in
> case it's not I thought I should post my problem to the list.
> 
> I recently upgraded my motherboard to one with an ICH4 IDE controller.
> Since it's not supported in 2.4.*, yet, I decided now would be a good time

2.4.20-rc4 should handle your ICH4 fine

2.5.49 needs new very different module tools

