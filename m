Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSHKAAA>; Sat, 10 Aug 2002 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHJX77>; Sat, 10 Aug 2002 19:59:59 -0400
Received: from mail013.syd.optusnet.com.au ([210.49.20.171]:38115 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S317373AbSHJX77>; Sat, 10 Aug 2002 19:59:59 -0400
Date: Sun, 11 Aug 2002 10:03:40 +1000
From: Pete de Zwart <dezwart@froob.net>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
Message-ID: <20020811000340.GF27819@niflheim>
References: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil>
User-Agent: Mutt/1.3.28i
X-environment: Linux niflheim 2.4.19 i686 /dev/pts/2
X-Url: http://froob.net/~dezwart/
X-Organisation: Froob Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, thanx Jesse, I always wondered what the history was behind it and
how to achieve it.

Here is another query:

If each printer had their own set of error codes, what would be the way to
implement their display from the kernel?

Would each printer have to have their own module if they had a non-standard
list of error codes or would we simply ignore them and state that the
ill conforming printer is on fire?

	Pete de Zwart.

-- 
The real reason your computer crashed, thanx to the BOFH:
"Your processor does not develop enough heat."
