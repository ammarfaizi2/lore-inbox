Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbUKXJYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUKXJYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUKXJYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:24:53 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:60432 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S262559AbUKXJWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:22:09 -0500
Subject: Regarding the map variable in free_area_struct
From: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1101288227.3787.20.camel@myLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 24 Nov 2004 14:53:47 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is said in TLDP doc for the kernel that map variable is used as a
bitmask. If Nth block is free, correspondingly the Nth bit is set. How
is this implemented using the map variable? what I cant comprehend is
the significance of making map as:

"unsigned long* map"

Can someone help me in this regard!!

-- 
With regards,

Jagadeesh Bhaskar P

