Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSHIRHz>; Fri, 9 Aug 2002 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHIRHz>; Fri, 9 Aug 2002 13:07:55 -0400
Received: from host.greatconnect.com ([209.239.40.135]:30226 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S312938AbSHIRHz>; Fri, 9 Aug 2002 13:07:55 -0400
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
From: Samuel Flory <sflory@rackable.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Pete de Zwart <dezwart@froob.net>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <15699.31589.634056.607809@kim.it.uu.se>
References: <20020809060344.GC6340@niflheim> 
	<15699.31589.634056.607809@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 10:10:56 -0700
Message-Id: <1028913064.1380.493.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 01:20, Mikael Pettersson wrote:
> Pete de Zwart writes:
>  > Is there a reason that in 2.4.19's drivers/usb/printer.c if the printer status
>  > code from is greater than 2 it states that it is on fire instead of printing
>  > the unknown error code?
> 
> Dunno, but the parport lp.c also goes into "printer on fire" mode, in my case
> whenever the black ink cartridge becomes empty :-(
> 


  The printer on fire message is the traditional Un*x error message for
unknown error on a printer.


