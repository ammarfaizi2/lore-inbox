Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRBFGvC>; Tue, 6 Feb 2001 01:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbRBFGux>; Tue, 6 Feb 2001 01:50:53 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:50473 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129339AbRBFGui>; Tue, 6 Feb 2001 01:50:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John R Lenton <john@grulic.org.ar>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on module onload 
In-Reply-To: Your message of "Tue, 06 Feb 2001 02:14:21 -0300."
             <20010206021421.A3156@grulic.org.ar> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 17:50:30 +1100
Message-ID: <1484.981442230@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001 02:14:21 -0300, 
John R Lenton <john@grulic.org.ar> wrote:
>I'm getting oopsen on unloading the USB modules; when I run
>ksymoops over the oops it decodes into any-vegetable-module (I
>assume because the ksyms are no longer the same). In what way
>could I obtain a meaningul decoded oops?

man insmod, find ksymoops assistance.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
