Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSDJXLl>; Wed, 10 Apr 2002 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313926AbSDJXLk>; Wed, 10 Apr 2002 19:11:40 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6882 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313924AbSDJXLj>;
	Wed, 10 Apr 2002 19:11:39 -0400
Importance: Normal
Sensitivity: 
Subject: Getting file attributes
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF201A5533.4F892774-ON85256B97.007A3CEE@raleigh.ibm.com>
From: "Niki Rahimi" <narahimi@us.ibm.com>
Date: Wed, 10 Apr 2002 18:11:38 -0500
X-MIMETrack: Serialize by Router on D04NMS33/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 07:11:38 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
      I have been working on finding a system call that will retrieve the
current file's attributes, especially the file owner and permissions. have
seen VOP_GETATTR()  in OpenBSD, which returns such information in a
structure. Is there anything equivalent to this on the Linux kernel?
       I've been searching through the kernel code for something equivalent
but my paths have lead me nowhere.

Thanks,
Niki

Niki A. Rahimi
LTC Security Development
narahimi@us.ibm.com

