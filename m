Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUARLZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUARLZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 06:25:14 -0500
Received: from main.gmane.org ([80.91.224.249]:26798 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263832AbUARLZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 06:25:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Dangerout FAT32 filesystem bug
Date: Sun, 18 Jan 2004 12:24:30 +0100
Message-ID: <1383334.RWlT9uk5eq@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't find anything in the changelog for 2.6.[01] and 2.4.2[2345]:

has the FAT32 FS bug mentioned (and successfully fixed/patched) in 

http://seclists.org/lists/linux-kernel/2003/Dec/1127.html

been included in the mainstream kernel? It destroys data on big FAT32
partitions, which is very critical for people with big external harddisks
trying to exchange data between Linux and Windows systems.


-- 
Jens Benecke
