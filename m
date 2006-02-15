Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422763AbWBONEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWBONEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWBONEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:04:35 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:22277 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1422763AbWBONEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:04:34 -0500
Message-ID: <43F326DF.8050700@argo.co.il>
Date: Wed, 15 Feb 2006 15:04:31 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
References: <20060215085456.GA2481@localhost.localdomain> <20060215010559.55b55414.akpm@osdl.org> <20060215093136.GA2600@localhost.localdomain> <43F30346.1070802@argo.co.il> <20060215104345.GA2879@localhost.localdomain>
In-Reply-To: <20060215104345.GA2879@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 13:04:32.0624 (UTC) FILETIME=[5CF86700:01C63230]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>>in my /etc/sysctl.conf, its meaning silently changes. I'll know about 
>>it during the next oomkiller pass.
>>    
>>
>
>Indeed. See, the breakage doesn't hurt.
>  
>
I guess we have different definitions for 'hurt' in our dictionaries.

-- 
error compiling committee.c: too many arguments to function

