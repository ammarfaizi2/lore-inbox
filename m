Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269222AbUISLa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbUISLa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 07:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUISLa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 07:30:57 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:63457 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269216AbUISL3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 07:29:07 -0400
Message-ID: <cone.1095593338.652311.21621.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: ck@vds.kolivas.org
Subject: [PATCH] Staircase cpu scheduler v8.4
Date: Sun, 19 Sep 2004 21:28:58 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick announcement that the latest version of the staircase cpu scheduler 
(v8.4) has been resynced with 2.6.9-rc2 and 2.6.9-rc2-mm1. They can both be 
found here:

http://ck.kolivas.org/patches/2.6/2.6.9/

Changes in the recent releases include much better cpu accounting for short 
running tasks improving fairness of cpu resources for such tasks, lots of 
little code cleanups and resyncing with current code.

Cheers,
Con

