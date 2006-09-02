Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWIBG5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWIBG5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 02:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWIBG5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 02:57:39 -0400
Received: from relay1.beelinegprs.ru ([217.118.71.5]:9969 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S1750821AbWIBG5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 02:57:39 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [Fwd: [-mm patch] fs/reiser4/: possible cleanups]
Date: Sat, 2 Sep 2006 10:54:37 +0400
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@fs.tum.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <44F8971F.7060107@namesys.com>
In-Reply-To: <44F8971F.7060107@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609021054.37363.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (510/060831)
X-SpamTest-Info: Profile: Detect Standard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 September 2006 00:25, Hans Reiser wrote:
> Zam, do you have any intention of using page_detach_jnode ever again?

IMO unused code should be removed.

--
Thanks,
Alex.


-- 
VGER BF report: U 0.5
