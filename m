Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWEYHVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWEYHVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWEYHVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:21:38 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:61762 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965065AbWEYHVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:38 -0400
Message-ID: <44755B2A.7050205@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:18 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] usb gadget: patches to support ixp4xx platform
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:20 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:22 AM,
	Serialize complete at 05/25/2006 02:22:22 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

following patches update pxa2xx_udc driver and ixp4xx arch depended files.
This driver will be usable on ixp4xx platform without problems.

Current state is that the pxa2xx_udc.c can't be even compiled for
the IXP4xx platform.

Feedback and comments are highly appreciated.

Best regards,
Milan Svoboda

