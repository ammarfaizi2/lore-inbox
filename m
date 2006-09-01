Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWIAGex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIAGex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIAGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:34:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12980 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751197AbWIAGex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:34:53 -0400
Message-ID: <44F7D47E.7020906@cn.ibm.com>
Date: Fri, 01 Sep 2006 14:34:38 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
References: <44F67847.6030307@cn.ibm.com> <20060831074742.GD807830@melbourne.sgi.com> <44F6979C.4070309@cn.ibm.com> <20060831081726.GV5737019@melbourne.sgi.com>
In-Reply-To: <20060831081726.GV5737019@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:

>But that might be a good place to start. Can you see if you can
>reproduce the problem without this config option set?
>  
>
No, I can't reproduce this prlblem without the CONFIG_PPC_64K_PAGES
config option set, the fsstress testcase works fine.


