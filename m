Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbRBFFON>; Tue, 6 Feb 2001 00:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBFFOE>; Tue, 6 Feb 2001 00:14:04 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:10511 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129099AbRBFFNw>; Tue, 6 Feb 2001 00:13:52 -0500
Date: Tue, 6 Feb 2001 02:14:21 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops on module onload
Message-ID: <20010206021421.A3156@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm getting oopsen on unloading the USB modules; when I run
ksymoops over the oops it decodes into any-vegetable-module (I
assume because the ksyms are no longer the same). In what way
could I obtain a meaningul decoded oops?

 -- 
John Lenton (john@grulic.org.ar) -- Random fortune:
<apt> it has been said that redhat is the thing Marc Ewing wears on
      his head.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
