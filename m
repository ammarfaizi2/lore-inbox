Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWFHBEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWFHBEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWFHBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:04:08 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:50106 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932519AbWFHBEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:04:07 -0400
Date: Wed, 7 Jun 2006 15:52:32 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Johannes Stezenbach <js@linuxtv.org>
cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, netdev@vger.kernel.org, linux-xfs@oss.sgi.com,
       ecki@lina.inka.de, lkml@rtr.ca
Subject: Re: Updated sysctl documentation take #2
In-Reply-To: <20060607235631.GA10688@linuxtv.org>
Message-ID: <Pine.LNX.4.63.0606071551310.2093@qynat.qvtvafvgr.pbz>
References: <20060607205316.bbb3c379.diegocg@gmail.com> <20060607235631.GA10688@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Johannes Stezenbach wrote:

> On Wed, Jun 07, 2006, Diego Calleja wrote:
>> Since people didn't like the "many small files" approach, I've moved
>> it to directories containing index.txt files:
>>
>> Documentation/sysctl/vm/index.txt
>> Documentation/sysctl/net/core/index.txt
>
> Why not just
>
> Documentation/sysctl/vm.txt
> Documentation/sysctl/net/core.txt
>
> etc.?

better matching of the proc layout would be my guess.
