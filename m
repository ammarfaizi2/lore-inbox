Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVCCN1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVCCN1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVCCN12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:27:28 -0500
Received: from mx.freeshell.org ([192.94.73.21]:10700 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261671AbVCCN0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:26:40 -0500
Date: Thu, 3 Mar 2005 13:26:29 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200502130145.55761.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0503031323290.19394@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501122242.51686.dtor_core@ameritech.net> <Pine.NEB.4.61.0502121749290.25663@sdf.lonestar.org>
 <200502130145.55761.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

I fixed the problem by updating my BIOS.  My motherboard is an MSI K8T NEO 
FIS2R with a BIOS from 2004.  I just yesterday flashed the BIOS and now 
kernel 2.6.10 boots and responds to the keyboard fine.

The changelog for the MSI BIOS is here:
http://www.msicomputer.com/support/bios_result.asp?platform=AMD&model=K8T%20Neo-FIS2R/FSR%20(MS-6702)&newsearch=1



Thanks so much!!
Roey
