Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSFBNrU>; Sun, 2 Jun 2002 09:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSFBNrT>; Sun, 2 Jun 2002 09:47:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37881 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317181AbSFBNrS>; Sun, 2 Jun 2002 09:47:18 -0400
Subject: Re: 2.4.19-pre9-ac3 still OOPS when exiting X with i810 chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Kieu <haiquy@yahoo.com>
Cc: Andris Pavenis <pavenis@lanet.lv>, linux-kernel@vger.kernel.org
In-Reply-To: <20020602003438.73728.qmail@web10401.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jun 2002 15:52:23 +0100
Message-Id: <1023029543.23874.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 01:34, Steve Kieu wrote: 
> May be I should upgrade to XFree86-4.2.0 but as far as
> I know the dri module in the standard kernel is too
> old for 4.2.0 to enable dri....

The -ac kernel has XFree86 4.2.0 DRI with the required Radeon fixes
added on top and some locking fixes

