Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWHaPJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWHaPJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWHaPJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:09:48 -0400
Received: from mx-3.csfb.com ([198.240.130.80]:21156 "EHLO ny-bas07.csfb.com")
	by vger.kernel.org with ESMTP id S932349AbWHaPJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:09:47 -0400
X-Server-Uuid: 5550B271-82ED-434B-A796-B4B857A3107F
Message-ID: <F444CAE5E62A714C9F45AA292785BED30EB974E0@esng11p33001.sg.csfb.com>
From: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: libstdc++.so.5
Date: Thu, 31 Aug 2006 23:09:26 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
X-WSS-ID: 68E8243B2BC382860-01-03
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 Linux boxes. 1 running RHEL 3,  2.4.21 kernel. Other SLSE 9, 2.6.5 kernel. 

While porting an C++ application from RHEL to SLES we faced some issue and it was resolved when we imported libstdc++.so.5 from RHEL and forced the app to reference this on SLES, rather than glibc (which was different ) in /usr/lib. We only ported 1 library.

In RHEL, gcc was 3.2.3, in SLES it was 3.3.2. 

Is there any risk associated with this?  

Any input is appreciated. 

Thanks

Rajib



==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================

