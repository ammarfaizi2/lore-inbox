Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSHIGAG>; Fri, 9 Aug 2002 02:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSHIGAG>; Fri, 9 Aug 2002 02:00:06 -0400
Received: from mail021.syd.optusnet.com.au ([210.49.20.161]:36744 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S318158AbSHIGAG>; Fri, 9 Aug 2002 02:00:06 -0400
Date: Fri, 9 Aug 2002 16:03:44 +1000
From: Pete de Zwart <dezwart@froob.net>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: 2.4.19: drivers/usb/printer.c usblpX on fire
Message-ID: <20020809060344.GC6340@niflheim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-environment: Linux niflheim 2.4.19 i686 /dev/pts/5
X-Url: http://froob.net/~dezwart/
X-Organisation: Froob Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason that in 2.4.19's drivers/usb/printer.c if the printer status
code from is greater than 2 it states that it is on fire instead of printing
the unknown error code?

	Pete de Zwart.

-- 
The real reason your computer crashed, thanx to the BOFH:
"HTTPD Error 4004 : very old Intel cpu - insufficient processing power"
