Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269848AbRHIQI3>; Thu, 9 Aug 2001 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269844AbRHIQIT>; Thu, 9 Aug 2001 12:08:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13737 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269852AbRHIQID>; Thu, 9 Aug 2001 12:08:03 -0400
Importance: Normal
Subject: [PATCH] IBM Lanstreamer Token Ring
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4339F22D.56C8E5E0-ON85256AA3.00585353@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Thu, 9 Aug 2001 11:07:49 -0500
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/09/2001 12:07:50 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Available at:

http://oss.software.ibm.com/developer/opensource/linux/patches/tr/lanstreamer-2.4.7-ac3.patch.gz


Patch fixes hanging problem encountered by many:
     - rearracnged calls to netif_*_queue
     - made sure interrupts are re-enabled before exiting interrupt code
     - added ioctl functionality for debugging

Thanks go to Mike Sullivan and Mike Phillips for their help,
Kent

________________________________
Kent Yoder <yoder1@us.ibm.com>

