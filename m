Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSINT0Q>; Sat, 14 Sep 2002 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSINT0Q>; Sat, 14 Sep 2002 15:26:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:46068
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317482AbSINT0P>; Sat, 14 Sep 2002 15:26:15 -0400
Subject: Re: 2.4.20-pre5-ac3 IDE CDRW panic (reproducible)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linuxml@jimbrooks.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D837EB5.5040703@jimbrooks.org>
References: <3D837EB5.5040703@jimbrooks.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 20:32:47 +0100
Message-Id: <1032031967.13743.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 19:23, Jim Brooks wrote:
> I'm running 2.4.20-pre5 + ac3 + preemptible.
> 
> The kernel panicked when I tried to install a RPM file
> from an IDE CDRW writer drive.  I tried merely copying
> a file from the CD writer -- that panicked too.

You need pre5-ac5 to fix that. That may well fix it with pre-empt
patches too

