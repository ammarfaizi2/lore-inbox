Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbTHUHMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTHUHMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:12:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:11419 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262487AbTHUHMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:12:05 -0400
Subject: Re: usb-storage: how to ruin your hardware(?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>
References: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061449894.3029.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 21 Aug 2003 08:11:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-21 at 02:34, H.Rosmanith (Kernel Mailing List) wrote:
> hi,
> 
> just today, I bought an "USB BAR", a 128MB flash disk. I managed to make
> the device unusable and only get scsi-errors from it.

Are you sure it didnt just fail. The report you give basically says
"after the first write the flash device failed entirely". That doen't 
seem an abnormal flash failure mode

