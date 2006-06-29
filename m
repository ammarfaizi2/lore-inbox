Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWF2VvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWF2VvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2VvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:51:04 -0400
Received: from [200.23.9.66] ([200.23.9.66]:9098 "EHLO
	CORREOAGS03.inegi.gob.mx") by vger.kernel.org with ESMTP
	id S932906AbWF2Vuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:50:40 -0400
Message-ID: <44A44AED.9080400@inegi.gob.mx>
Date: Thu, 29 Jun 2006 16:49:33 -0500
From: David Gama Rodriguez <david.gama@inegi.gob.mx>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: %libata ICH7 2.4.26
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2006 21:49:59.0091 (UTC) FILETIME=[F7900030:01C69BC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone !!!!

Basically the thing is this: I need to build a cluster using openmosix

what I have is :

       Distro: Gentoo 2006.0
       Kernel: 2.4.32
       HW:      Pentium IV  3.20 Ghz  intel  chipset 945G (ICH7 family)
       HD:       SATA 

But for openmosix I need 2.4.26 kernel which doesnt support SATA, so I 
used it  and pacth it with the 2.4.26-rc1-libata3.patch but this patch 
doesnt have the support for my chipset.

The question is there any pactch with the most recent update for libata 
for this kernel or how can I add support to my kernel with libata with 
support for the Intel PIIX driver

Thanks in advance
