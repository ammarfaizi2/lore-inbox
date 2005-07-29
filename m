Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVG2AcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVG2AcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVG2AcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:32:07 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:65203 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261579AbVG2AcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:32:02 -0400
Date: Fri, 29 Jul 2005 01:31:53 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: io scheduler silly question perhaps..
Message-ID: <Pine.LNX.4.58.0507290130000.1030@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an embedded system which has two read-only flash devices (one a
PIO ATA flash disk, and one MDMA capable flash)

As I'm doing no writing in this system and most of my reads are sequential
(streaming movies or images) would my choice of io scheduler be very
important?

Regards,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

