Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUJ1OWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUJ1OWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUJ1OWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:22:19 -0400
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:3724 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261410AbUJ1OUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:20:51 -0400
X-Ironport-AV: i="3.86,109,1096862400"; 
   d="scan'208"; a="390419328:sNHT16120716"
Message-ID: <009f01c4bcf9$39f98930$0200a8c0@haneyhbmu5pv2g>
From: "Ameer Armaly" <ameer@charter.net>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: cisco aironet 4800 pci wireless card not configuring properly
Date: Thu, 28 Oct 2004 10:19:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
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
