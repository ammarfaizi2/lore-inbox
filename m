Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFOV4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFOV4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVFOVzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:55:06 -0400
Received: from fmr24.intel.com ([143.183.121.16]:20922 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261602AbVFOVjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:39:18 -0400
Message-Id: <200506152139.j5FLd3g26510@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Badari Pulavarty'" <pbadari@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: RE: 2.6.12-rc6-mm1 & 2K lun testing
Date: Wed, 15 Jun 2005 14:39:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVx1DqgW4QqkdJPQxec/1r8sj8ZMQAHiaDA
In-Reply-To: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote on Wednesday, June 15, 2005 10:36 AM
> I sniff tested 2K lun support with 2.6.12-rc6-mm1 on
> my AMD64 box. I had to tweak qlogic driver and
> scsi_scan.c to see all the luns.
> 
> (2.6.12-rc6 doesn't see all the LUNS due to max_lun
> issue - which is fixed in scsi-git tree).
> 
> Test 1:
> 	run dds on all 2048 "raw" devices - worked
> great. No issues.

Just curious, how many physical disks do you have for this test?

