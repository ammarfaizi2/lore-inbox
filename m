Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSLARNQ>; Sun, 1 Dec 2002 12:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSLARNQ>; Sun, 1 Dec 2002 12:13:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14492 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261973AbSLARNQ>; Sun, 1 Dec 2002 12:13:16 -0500
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xizard@enib.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DEA322B.40204@enib.fr>
References: <3DEA322B.40204@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Dec 2002 17:53:53 +0000
Message-Id: <1038765233.30392.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 16:00, XI wrote:
> Hi,
> [1] With kernel-2.4.19 and kernel-2.4.20 the sound stutter, sizzle
> 
> [2] The problem seems be correlated with my PCI graphic card (matrox
> G200 PCI) and my sound card (sound blaster live 5.1).
> In fact every time I listen music and that something appens on my screen
> (moving a window, watching a movie) the sound stutter.

Make sure you have the XFree86 settings for the Matrox right -in
paticular the PCI retry option

