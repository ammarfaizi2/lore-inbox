Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUCMBiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUCMBiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:38:25 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:59409 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262939AbUCMBiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:38:24 -0500
Date: Sat, 13 Mar 2004 09:38:44 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: help ... pppd can't detect incoming connection
Message-ID: <Pine.LNX.4.58.0403130936300.517@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/13/2004
 09:38:20 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/13/2004
 09:38:23 AM,
	Serialize complete at 03/13/2004 09:38:23 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can dial out using pppd, but pppd can't detect incoming connection.

Modem answers the incoming ring, but pppd doesn't process the do anything.


linux 2.6.4
slmodem-2.9.6


Thanks,
Jeff

