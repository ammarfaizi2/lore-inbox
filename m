Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTHVQ7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTHVQ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:56:45 -0400
Received: from evrtwa1-ar2-4-33-045-084.evrtwa1.dsl-verizon.net ([4.33.45.84]:14809
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S263898AbTHVQyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:54:37 -0400
Message-ID: <3F464AC9.5040907@candelatech.com>
Date: Fri, 22 Aug 2003 09:54:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Sodre Carlos <klist@i-a-i.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reinjecting IP Packets
References: <1061563295.824.4.camel@iai68>	 <3F464177.1020709@candelatech.com> <1061569442.2060.2.camel@iai68> <3F464A96.3070408@candelatech.com>
In-Reply-To: <3F464A96.3070408@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Patrick Sodre Carlos wrote:
> 
>>    My mistake... I forgot to mention that the packet will be coming from
>> user-space.
>>
>> Patrick
> 
> 
> Maybe net_queue_xmit() then?
I meant dev_queue_xmit()

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


