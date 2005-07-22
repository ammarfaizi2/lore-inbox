Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGVOBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGVOBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVGVOBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:01:05 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:51383 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S262091AbVGVOA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:00:57 -0400
Subject: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
From: Milind Dumbare <milind@linsyssoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 22 Jul 2005 19:34:38 +0530
Message-Id: <1122041079.3556.18.camel@matrix.linsyssoft.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	LinSysSoft Technologies  has taken up the challenge to incorporate
Checkpoint and Block Level Incremental Backup (BLIB) support in the open
source's Ext3 File System, which is very well known for its stability,
to create a new file system called CheckFS. Block Level Incremental
Backup enables truly efficient backup and restore mechanisms.
Checkpoints provide administrators to create point-in-time copies of a
live file system by keeping track of the data blocks modified in real
time. 

For further information and a downloadable working prototype of this
technology go to : http://checkfs.linsyssoft.com

....Milind Dumbare
(www.linsyssoft.com)

