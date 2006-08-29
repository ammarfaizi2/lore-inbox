Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWH2Hb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWH2Hb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWH2Hb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:31:26 -0400
Received: from smtp1.enomia.com ([64.128.160.11]:63753 "EHLO smtp1.enomia.com")
	by vger.kernel.org with ESMTP id S932159AbWH2HbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:31:25 -0400
Message-ID: <44F3ED45.7080502@uplogix.com>
Date: Tue, 29 Aug 2006 02:31:17 -0500
From: Paul B Schroeder <pschroeder@uplogix.com>
Reply-To: pschroeder@uplogix.com
Organization: Uplogix, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "'TechSupport'" <techsupport@moschip.com>, AJN Rao <ajnrao@moschip.com>,
       AJN Rao <ajn@moschip.com>
Subject: [PATCH] Moschip 7840 USB-Serial Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH-ID: _16B2DEF3-E0AE-415C-85D2-641185C139C9_
X-CTCH-RefID: str=0001.0A090206.44F3EC10.003F,ss=1,fgs=0
X-CTCH-Action: Ignore
X-OriginalArrivalTime: 29 Aug 2006 07:31:19.0763 (UTC) FILETIME=[1ED92A30:01C6CB3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Worked with the tech support folks at Moschip Semiconductor to get the driver 
working on the latest kernel.  We've been using it for a bit now and it appears 
to be working well.  They're okay with kernel inclusion of the driver.  I've 
cleaned it up a bit and put this patch together.

The patch is against 2.6.18-rc5.  Please apply, it can be found here:
http://paul.schroeder.name/DEV/kernel/mos7840.patch

Thanks...Paul...


-- 
---

Paul B Schroeder <pschroeder "at" uplogix "dot" com>
Senior Software Engineer
Uplogix, Inc. (http://www.uplogix.com/)

