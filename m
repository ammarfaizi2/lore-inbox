Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319151AbSIDMRD>; Wed, 4 Sep 2002 08:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSIDMRD>; Wed, 4 Sep 2002 08:17:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:5620 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319151AbSIDMRC>; Wed, 4 Sep 2002 08:17:02 -0400
Subject: Re: writing OOPS/panic info to nvram?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200209041350.21358.roy@karlsbakk.net>
References: <200209041350.21358.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 13:21:33 +0100
Message-Id: <1031142093.2796.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 12:50, Roy Sigurd Karlsbakk wrote:
> hi
> 
> I just read in the OS X.2 technote 
> (http://developer.apple.com/technotes/tn2002/tn2053.html#TN001016) that 
> they're writing the panic dump to nvram.
> 
> Is it hard to implement this on Linux?

Its been done years ago. However on a PC you basically have no free
nvram so its not terribly useful there.

