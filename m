Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUA1NUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUA1NUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:20:06 -0500
Received: from cerberus.ucs.mun.ca ([134.153.232.162]:59656 "EHLO smtp.mun.ca")
	by vger.kernel.org with ESMTP id S265916AbUA1NUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:20:03 -0500
From: Stephen Anthony <stephena@cs.mun.ca>
To: linux-kernel@vger.kernel.org
Subject: Status of UDF write on DVD-R(W) and CD-R(W) disks?
Date: Wed, 28 Jan 2004 09:50:01 -0330
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401280950.01174.stephena@cs.mun.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering about the status of UDF write support on DVD and CD media.  
Specifically, does anyone know when (or even if) it will be possible to 
do incremental writes on DVD-R or CD-R media using UDF and standard 
system tools (cp and the like)?  I'd like to treat a DVD-R like a small 
disk, and do mount, cp ..., umount.  Basically have everything work like 
a hard disk, except of course there would be no delete.

Please CC me if you want to response personally (I'm not subscribed to the 
list).

Thanks,
Steve

