Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSKGO7P>; Thu, 7 Nov 2002 09:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSKGO7P>; Thu, 7 Nov 2002 09:59:15 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:40750 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261206AbSKGO7M>; Thu, 7 Nov 2002 09:59:12 -0500
Message-ID: <3DCA8140.1A4A48DE@cinet.co.jp>
Date: Fri, 08 Nov 2002 00:05:36 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-ac1-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 5/17] support PC-9800 against 2.5.45-ac1 (apm)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>  <3DC956DF.87014B43@cinet.co.jp> <1036600885.19924.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> 
> On Wed, 2002-11-06 at 12:52, Osamu Tomita wrote:
> > This patch add APM support for PC-9800.
> > We need these change according to BIOS difference.
> 
> Hello.
> 
> Are these patches complete?  The list
> seems to cut off a portion of each patch.
Hi.
PC-9800 patchset has been smaller.
Several parts are already in 2.5.45-ac1. Sound drivers
are already in ALSA CVS. :-)
And I remove several patches from patchset that need
more testing. For example, FB console, serial driver,
oss sound drivers.

Thanks!
Osamu
