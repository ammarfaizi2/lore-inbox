Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbSJFQKu>; Sun, 6 Oct 2002 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJFQKu>; Sun, 6 Oct 2002 12:10:50 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:20465 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261651AbSJFQKu>; Sun, 6 Oct 2002 12:10:50 -0400
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210061608.51459.jan-hinnerk_reichert@hamburg.de>
References: <200210061608.51459.jan-hinnerk_reichert@hamburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:25:40 +0100
Message-Id: <1033921540.21282.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 15:08, Jan-Hinnerk Reichert wrote:
> I have 2.4.19 without any patches, three ide harddrives, no CD-ROM.
> I quite like the data on my machine, so I won't install an 2.4.20-pre on it 
> ;-(

2.4.20pre has the same IDE code as 2.4.19, plus some PCI layer not IDE
layer changes to support i845 systems

