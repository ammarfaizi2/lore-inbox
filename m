Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbSKLXAr>; Tue, 12 Nov 2002 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKLW74>; Tue, 12 Nov 2002 17:59:56 -0500
Received: from graze.net ([65.207.24.2]:23433 "EHLO graze.net")
	by vger.kernel.org with ESMTP id <S267011AbSKLW7u>;
	Tue, 12 Nov 2002 17:59:50 -0500
Date: Tue, 12 Nov 2002 18:06:34 -0500 (EST)
From: "Brian C. Huffman" <sheep@graze.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio
In-Reply-To: <1036971426.1099.33.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan / All,

	I assume this is the patch that's been in your -ac kernels for a 
while?  I have an Intel 845GBV board which uses the ICH4 architecture.  
I'm happy to report that this patch does allow me to use the integrated 
sound on this motherboard, but one thing that I've noticed is that it 
seems as though to adjust volume you need to adjust the actual channel 
(PCM, CD, etc), rather than main volume.  Any ideas why this might be so?

Brian

