Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136519AbRD3UJG>; Mon, 30 Apr 2001 16:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136518AbRD3UI5>; Mon, 30 Apr 2001 16:08:57 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59301 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S136516AbRD3UIi>; Mon, 30 Apr 2001 16:08:38 -0400
Subject: Announcing Journaled File System (JFS) beta 3 release 0.3.0 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFC00CF673.17FBEA27-ON85256A3E.006D8249@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Mon, 30 Apr 2001 15:08:31 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/30/2001 04:08:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The beta 3 release 0.3.0 of JFS was made available today.

The file system has fixes included.

Both the file system and the utilities have been changed to use
the system endian macros,so that JFS will now store the meta-data
as little endian when running on all architectures.

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/developerworks/opensource/jfs




