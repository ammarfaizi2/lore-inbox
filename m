Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbTIFTmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIFTmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:42:46 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:11977 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S261795AbTIFTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:42:45 -0400
Message-ID: <3F5A38B2.7050802@genebrew.com>
Date: Sat, 06 Sep 2003 15:42:42 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: "'Robert Love'" <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
In-Reply-To: <000101c374a3$2d2f9450$f40a0a0a@Aria>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Yau wrote:
> How come Ingo's granular timeslice patch didn't get put into
> 2.6.0-test4?

It is being tested in Andrew's mm kernels, along with Con's tweaks.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

