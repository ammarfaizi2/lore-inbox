Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUFPUOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUFPUOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUFPUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:14:14 -0400
Received: from roasted.cubic.org ([193.108.181.130]:57030 "EHLO
	roasted.cubic.org") by vger.kernel.org with ESMTP id S264737AbUFPUOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:14:01 -0400
Message-ID: <40D0AA07.7010806@cubic.org>
Date: Wed, 16 Jun 2004 22:13:59 +0200
From: Dirk Jagdmann <doj@cubic.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE Auto-Geometry Resizing support missing in 2.6.7?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel Developers,

I have just updated from 2.6.6 to 2.6.7. I need to use the IDE 
Auto-Geometry Resizing support on my system (CONFIG_IDEDISK_STROKE). The 
corresponding configuration option however was removed in 2.6.7 along 
with the define in the .config file. Thus when booting my hard disks are 
not properly detected (only with the clipped capacity).

Was the removal of this option intentional? Was the option renamed or moved?

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org
