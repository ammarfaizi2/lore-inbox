Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbRGKGMB>; Wed, 11 Jul 2001 02:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbRGKGLu>; Wed, 11 Jul 2001 02:11:50 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:24543 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S267208AbRGKGLn>;
	Wed, 11 Jul 2001 02:11:43 -0400
Date: Wed, 11 Jul 2001 15:11:41 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irq problem with OHCI USB
In-Reply-To: <Pine.LNX.4.30.0107111256280.2424-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.30.0107111505370.664-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 00:05.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])

Going through the (Japanese) documentation for this box, I noticed that no
claim is made that the USB ports actually work.  Certainly they are there,
and a controller appears to be there; but it seems at least possible that
they are not connected.

Ah well, 2.4.6 is running fine otherwise.

