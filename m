Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTIMSH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTIMSH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:07:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60827 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262078AbTIMSH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:07:57 -0400
Subject: Re: st_options.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Somsak RAKTHAI <rsomsak@mor-or.pn.psu.ac.th>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.43.0309131716590.19568-100000@mor-or>
References: <Pine.GSO.4.43.0309131716590.19568-100000@mor-or>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063476386.8702.37.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 19:06:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 11:26, Somsak RAKTHAI wrote:
> Dear sir,
>   I used Linux RedHat 7.2. My kernel is 2.4.7-10smp.
> I want to modify file below to make new kernel.
>     /usr/src/linux/drivers/scsi/st_options.h

Make sure you have kernel-source installed (I'd also strongly advise
you to update to the errata packages for 7.2 if you can).

Alan

