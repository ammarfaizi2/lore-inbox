Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbSIYVFp>; Wed, 25 Sep 2002 17:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262016AbSIYVFp>; Wed, 25 Sep 2002 17:05:45 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:8488 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S262005AbSIYVFm>; Wed, 25 Sep 2002 17:05:42 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEC2@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: ACPI: kill extra whitespace
Date: Wed, 25 Sep 2002 14:10:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 
> Hi!
> 
> Tiny patch..
> 							Pavel
> 
> --- clean/include/linux/acpi.h	2002-09-22 
> 23:47:01.000000000 +0200
> +++ linux-swsusp/include/linux/acpi.h	2002-09-22 
> 23:53:34.000000000 +0200
> @@ -365,9 +365,7 @@
>  extern int acpi_mp_config;
>  
>  #else
> -
>  #define acpi_mp_config	0
> -
>  #endif

Pavel,

I was deliberate in my use of the enter key when adding that code. That's
the way the rest of the file looks. Please leave it.

Thanks -- Regards -- Andy
