Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUHIEGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUHIEGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUHIEGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:06:55 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:18072 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264833AbUHIEGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:06:49 -0400
Message-ID: <cone.1092024397.462058.26660.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: ck@vds.kolivas.org
Subject: [PATCH] Staircase scheduler for 2.6.8-rc3-mm2
Date: Mon, 09 Aug 2004 14:06:37 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've resynced the latest version of my staircase scheduler to suit 
2.6.8-rc3-mm2.

There have been a number of changes made to the scheduler to address 
all the concerns raised about it when it was included in 2.6.8-rc2-mm2.

Here is a link to a patch that includes the nmi fix and adds staircase v7.I

http://ck.kolivas.org/patches/2.6/2.6.8/2.6.8-rc3-mm2/2.6.8-rc3-mm2-fixes-an 
d-staircase7.I.bz2

Cheers,
Con

