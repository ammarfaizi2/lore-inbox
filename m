Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311875AbSCOARo>; Thu, 14 Mar 2002 19:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311876AbSCOARe>; Thu, 14 Mar 2002 19:17:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18950 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311875AbSCOARW>; Thu, 14 Mar 2002 19:17:22 -0500
Subject: Re: Will XFree86-4.2.0 dri modules come to 2.4.x kernel? (Note for jp8 kernel)
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Fri, 15 Mar 2002 00:32:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20020315000938.63500.qmail@web10401.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at Mar 15, 2002 11:09:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lfeJ-0002MF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, this problem is with 2.4.19-pre3-jp8 kernel.
> With 2.4.19-pre2-ac4 it is fine. I dont know why ;
> here is from the log file

Ok so 4.2 really does want a newer DRM module than 4.1. 4.1 works with
the 4.2 modules.

The -ac tree has an rmapified 4.2 DRM so that one would work. 4.2 DRM for
older 2.4 (needs some clean up for current 2.4) is in the XFree86 CVS
or the tar balls from xfree86.org. 

