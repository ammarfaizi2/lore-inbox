Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUJYOeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUJYOeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:34:24 -0400
Received: from mxsf19.cluster1.charter.net ([209.225.28.219]:40325 "EHLO
	mxsf19.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261817AbUJYOeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:34:19 -0400
X-Ironport-AV: i="3.86,98,1096862400"; 
   d="scan'208"; a="475278663:sNHT12366136"
Message-ID: <003501c4ba9f$98396080$0200a8c0@haneyhbmu5pv2g>
From: "Ameer Armaly" <ameer@charter.net>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: cisco arionet 4800 card not configuring properly
Date: Mon, 25 Oct 2004 10:33:28 -0400
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
I'm running debian unstable on an athlon 2.07 ghz with 256 mb ram.
---
Life is either tragedy or comedy.
 Usually it's your choice. You can whine or you can laugh.
--Animorphs
