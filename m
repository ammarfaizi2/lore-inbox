Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUE3RzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUE3RzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbUE3RzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:55:25 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:56008 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264288AbUE3RzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:55:21 -0400
Message-ID: <40BA1FD5.9080902@minimum.se>
Date: Sun, 30 May 2004 19:54:29 +0200
From: Martin Olsson <mnemo@minimum.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why is proper NTFS-driver difficult?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I was wondering why is there no Linux NTFS-driver which allows full 
writing etc? Is there something that makes this particular difficult to 
implement? I mean Linux supports so many file systems, why has proper 
NTFS support been neglected?

Is there any file system I can use which satisfies these criteria:
A) works in both Linux and Windows
B) handle >4GB files
C) handle 120GB partitions


Sincerly,
/m
