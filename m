Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262388AbRENTEk>; Mon, 14 May 2001 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRENTEa>; Mon, 14 May 2001 15:04:30 -0400
Received: from intranet.resilience.com ([209.245.157.33]:44522 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262388AbRENTEV>; Mon, 14 May 2001 15:04:21 -0400
Message-ID: <3B002D61.191C03C@resilience.com>
Date: Mon, 14 May 2001 12:09:21 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 kernel reports wrong amount of physical memory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I installed the 2.4.4 kernel on a dual P3-733 system with 1 GB of ECC RAM and found that /proc/meminfo reports back only 899MB of RAM.  The 2.4.2 kernel (with RedHat patches from the 7.1 release) worked fine as did the 2.4.0 kernel (with RedHat patches from the 7.0 release).

Anyone know what is going on with 2.4.4?  At POST, the BIOS reports 1024MB.

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
