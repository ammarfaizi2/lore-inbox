Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUE0JLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUE0JLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUE0JLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 05:11:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261851AbUE0JLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 05:11:15 -0400
Date: Thu, 27 May 2004 10:11:33 +0100
From: thornber@redhat.com
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com
Subject: [Patch 1/1] dm: change maintainer
Message-ID: <20040527091133.GS1254@nimzo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change of device-mapper maintainer.
--- diff/MAINTAINERS	2004-05-14 11:02:05.000000000 +0100
+++ source/MAINTAINERS	2004-05-27 10:07:58.074452424 +0100
@@ -632,10 +632,9 @@ W:	http://www.debian.org/~dz/i8k/
 S:	Maintained
 
 DEVICE-MAPPER
-P:	Joe Thornber
-M:	dm@uk.sistina.com
-L:	linux-lvm@sistina.com
-W:	http://www.sistina.com/lvm
+P:	Alasdair Kergon
+L:	dm-devel@redhat.com
+W:	http://sources.redhat.com/dm
 S:	Maintained
 
 DEVICE NUMBER REGISTRY
