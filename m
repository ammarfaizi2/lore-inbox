Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWJQQPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWJQQPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJQQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:15:25 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:59889 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751175AbWJQQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:15:24 -0400
Message-ID: <45350182.8030801@cn.ibm.com>
Date: Wed, 18 Oct 2006 00:14:58 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression] cpu hotplug failed on kernel 2.6.19-rc2
References: <4534D7C6.2080402@cn.ibm.com> <20061017161251.GB18689@localdomain>
In-Reply-To: <20061017161251.GB18689@localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch 写道:
> Yao Fei Zhu wrote:
> 
> 
>>Running cpu hotplug regression tsstcase lhcs_regression on kernel
>>2.6.19-rc2/IBM System p5 will fall into xmon.
> 
> 
> Your subject implies this is a regression; what is the most recent
> kernel that worked?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
2.6.18 works. Not tested on 2.6.19-rc1.

