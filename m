Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUBLHeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUBLHeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:34:15 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:8861 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S266295AbUBLHeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:34:11 -0500
Message-ID: <402B2C65.6050604@iitbombay.org>
Date: Thu, 12 Feb 2004 13:03:57 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 PATCH : UFS2  filesystem support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I am trying to produce some patches to be able to
support UFS2 (of FreeBSD 5.x )  filesystem.
 
The work-in-progress patches are available from

http://ufs-linux.sourceforge.net/ufs2/p1.txt
http://ufs-linux.sourceforge.net/ufs2/p2.txt

Currently , these provides the bare minimum  ufs2
support and that also for Read-Only .

This is just a snapshot so several things simply may not work.
But atleast I was able to mount my ufs2 partition
(from a FreeBSD 5.2 install ) and read files.

Some testing will be good on them, though.

Niraj

