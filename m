Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbSJFVX3>; Sun, 6 Oct 2002 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJFVX2>; Sun, 6 Oct 2002 17:23:28 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:20982 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262202AbSJFVX1>; Sun, 6 Oct 2002 17:23:27 -0400
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210062156.43637.jan-hinnerk_reichert@hamburg.de>
References: <200210061608.51459.jan-hinnerk_reichert@hamburg.de>
	<1033921540.21282.2.camel@irongate.swansea.linux.org.uk> 
	<200210062156.43637.jan-hinnerk_reichert@hamburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 22:38:18 +0100
Message-Id: <1033940298.21282.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 20:56, Jan-Hinnerk Reichert wrote:
> Thanks, I didn't knew that.
> 
> Anyway, could the new PCI layer increase IDE-DMA stability on systems other 
> than i845?

It only related to initialization

