Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUIAF1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUIAF1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUIAF1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:27:08 -0400
Received: from lan-202-144-86-147.maa.sify.net ([202.144.86.147]:28293 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S268633AbUIAF1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:27:06 -0400
Message-ID: <41355D2A.8060404@toughguy.net>
Date: Wed, 01 Sep 2004 10:54:58 +0530
From: Obelix <obelix123@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wise, Jeremey" <jeremey.wise@agilysys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
References: <1094008341.4704.32.camel@wizej.agilysys.com>
In-Reply-To: <1094008341.4704.32.camel@wizej.agilysys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>"Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)" 
>  
>
Most likely a bad initrd. recheck where your /boot/initrd is pointing
to.

- obelix
