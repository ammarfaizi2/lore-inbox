Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBFI0P>; Tue, 6 Feb 2001 03:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBFI0F>; Tue, 6 Feb 2001 03:26:05 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:33295 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129033AbRBFIZz> convert rfc822-to-8bit; Tue, 6 Feb 2001 03:25:55 -0500
Date: Tue, 6 Feb 2001 05:26:14 -0300
From: John R Lenton <john@grulic.org.ar>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on module onload
Message-ID: <20010206052614.A692@grulic.org.ar>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010206021421.A3156@grulic.org.ar> <1484.981442230@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.12i
In-Reply-To: <1484.981442230@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Feb 06, 2001 at 05:50:30PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 05:50:30PM +1100, Keith Owens wrote:
> On Tue, 6 Feb 2001 02:14:21 -0300, 
> John R Lenton <john@grulic.org.ar> wrote:
> >I'm getting oopsen on unloading the USB modules; when I run
> >ksymoops over the oops it decodes into any-vegetable-module (I
> >assume because the ksyms are no longer the same). In what way
> >could I obtain a meaningul decoded oops?
> 
> man insmod, find ksymoops assistance.

doh!

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
El trabajo endulza siempre la vida, pero los dulces no le gustan a todo el mundo.
		-- Victor Hugo. (1802-1885) Novelista francés. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
