Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVETR4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVETR4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVETR4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:56:15 -0400
Received: from gannon.phys.uwm.edu ([129.89.61.108]:55745 "EHLO
	gannon.phys.uwm.edu") by vger.kernel.org with ESMTP id S261491AbVETR4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:56:14 -0400
Date: Fri, 20 May 2005 12:56:13 -0500 (CDT)
From: Adam Miller <amiller@gravity.phys.uwm.edu>
X-X-Sender: amiller@gannon.phys.uwm.edu
To: linux-kernel@vger.kernel.org
Subject: software RAID
Message-ID: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   We're looking to set up either software RAID 1 or RAID 10 using 2 SATA 
disks.  If a disk in drive A has a bad sector, can it be setup so that the 
array will read the sector from drive B and then have it rewrite the 
bad sector on drive A?  Please CC me in the response.

Thanks!
Adam Miller
