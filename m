Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSGNAdw>; Sat, 13 Jul 2002 20:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSGNAdv>; Sat, 13 Jul 2002 20:33:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30449 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315481AbSGNAdt>; Sat, 13 Jul 2002 20:33:49 -0400
Subject: Re: Status of DRI modules for i810 with > 2.4.19-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020713210243.62248.qmail@web10403.mail.yahoo.com>
References: <20020713210243.62248.qmail@web10403.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 02:45:49 +0100
Message-Id: <1026611149.13885.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 22:02, Steve Kieu wrote:
> Last time I tried 2.4.19-rc1-aa2 and the OOP still
> persists when exiting XFree86 (enable DRI with chipset
> i810)
> 
> Is there anybody who is working on this issue?

It should be fixed in the combination of stuff in 2.4.19rc1-ac3. Arjan
van de Ven has fixed several problems with the i810 DRI

