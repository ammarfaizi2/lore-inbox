Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKKWSm>; Mon, 11 Nov 2002 17:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSKKWSm>; Mon, 11 Nov 2002 17:18:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:34981 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261456AbSKKWSl>; Mon, 11 Nov 2002 17:18:41 -0500
Subject: Re: [PATCH] IDE out*() confusing argument names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Andre M. Hedrick" <andre@linux-ide.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0211111749060.21501-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0211111749060.21501-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 22:50:14 +0000
Message-Id: <1037055014.4648.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 16:52, Geert Uytterhoeven wrote:
> 
> Fix confusing arguments in the IDE access routines. The first arguments of the
> out*() routines are not addresses but values.

agreed

