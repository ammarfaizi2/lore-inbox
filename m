Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHIUkm>; Fri, 9 Aug 2002 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSHIUkm>; Fri, 9 Aug 2002 16:40:42 -0400
Received: from mail023.syd.optusnet.com.au ([210.49.20.162]:36254 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S315762AbSHIUkl>; Fri, 9 Aug 2002 16:40:41 -0400
Date: Sat, 10 Aug 2002 06:44:21 +1000
From: Pete de Zwart <dezwart@froob.net>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
Message-ID: <20020809204421.GA27819@niflheim>
References: <20020809060344.GC6340@niflheim> <15699.31589.634056.607809@kim.it.uu.se> <1028913064.1380.493.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028913064.1380.493.camel@flory.corp.rackablelabs.com>
User-Agent: Mutt/1.3.28i
X-environment: Linux niflheim 2.4.19 i686 /dev/pts/2
X-Url: http://froob.net/~dezwart/
X-Organisation: Froob Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Around about 1010h 09/08/2002, Samuel Flory emitted the following wisdom:
>   The printer on fire message is the traditional Un*x error message for
> unknown error on a printer.

	What I don't understand is why the misleading message is sent
instead of the printer driver stating that it has received an unknown printer
error code and printing the code number.

	Out of curiosity, does there exist an error code that a printer can
assert that specifies that it is "on fire"?

	Pete de Zwart.

-- 
The real reason your computer crashed, thanx to the BOFH:
"Repeated reboots of the system failed to solve problem"
