Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUAMU35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUAMU35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:29:57 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:8601 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265081AbUAMU3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:29:54 -0500
Message-ID: <40045539.9040709@nortelnetworks.com>
Date: Tue, 13 Jan 2004 15:29:45 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Scott Long <scott_long@adaptec.com>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed Enhancements to MD
References: <40036902.8080403@adaptec.com> <20040113081932.A721@lists.us.dell.com> <400436CC.7020007@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Matt Domsch wrote:
> 
>> I haven't seen the spec yet myself, but I'm lead to believe that
>> DDF allows for multiple logical drives to be created across a single
>> set of disks (e.g. a 10GB RAID1 LD and a 140GB RAID0 LD together on
>> two 80GB spindles), as well as whole disks be used.  It has a

How is this different than the 20GB RAID0 and 6 15BB RAID1s that I've 
got on two 100GB spindles right now?

I think its on 2.4, might even be 2.2.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

