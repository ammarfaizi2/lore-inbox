Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbUJ0MWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbUJ0MWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJ0MWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:22:19 -0400
Received: from mxsf23.cluster1.charter.net ([209.225.28.223]:57561 "EHLO
	mxsf23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262405AbUJ0MU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:20:59 -0400
X-Ironport-AV: i="3.86,107,1096862400"; 
   d="scan'208"; a="476707889:sNHT12598464"
Message-ID: <005c01c4bc1f$63e33820$0200a8c0@haneyhbmu5pv2g>
From: "Ameer Armaly" <ameer@charter.net>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: cisco aironet 4800 pci wireless card not configuring properly
Date: Wed, 27 Oct 2004 08:20:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.
I've got a cisco 4800 aironet card, that is detected successfully by the
driver in the kernel.  However, when I configure with ifup, it says that it
doesn't
understand hardware address 801 for wifi0.
I'm running debian unstable with kernel 2.6.8.1 on an athlon 2.07 ghz with 
256 mb ram.
---
Life is either tragedy or comedy.
 Usually it's your choice. You can whine or you can laugh.
--Animorphs 

