Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbWBIJnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbWBIJnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWBIJnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:43:06 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:10421 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S965222AbWBIJnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:43:05 -0500
Date: Thu, 09 Feb 2006 04:42:45 -0500
From: redhat <destructojunior@optonline.net>
Subject: Re: USB Host Stack Debugging
In-reply-to: <3AEC1E10243A314391FE9C01CD65429B31D121@mail.esn.co.in>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Message-id: <1139478164.5258.2.camel@localhost.localdomain>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <3AEC1E10243A314391FE9C01CD65429B31D121@mail.esn.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 04:21, Mukund JB. wrote:
> Dear All,
> 
> Please help me perform my case study over USB Host Hardware & general
> stack Architecture. My idea is to understand the Hardware.
> 
> I would like to explore the complete USB Host side stack. I have seen
> the Linus written early USB Debug Mouse Driver + Stack which is very
> compact and I guess this will help be debug the USB Architecture in
> whole.
> I have downloaded the USB Stack from
> ftp://ftp.kernel.org/pub/linux/kernel/testing/old/usb/usb-0.01.tar.gz
> 
> I understand from the Makefile of this version of USB Mouse + stack is
> for Linux 2.2v.
> But, which version of Linux 2.2 should I use exactly. I have asked this
> on USB Linux maillits. 
> Which version of Linux is compatible with USB Stack?
> 
> Thanks & Regards,
> Mukund Jampala
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

it *should* be compatible with 2.2.* (all 2.2 releases)

