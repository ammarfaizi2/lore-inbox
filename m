Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUANUri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUANUri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:47:38 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54465 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264271AbUANUrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:47:35 -0500
Message-ID: <4005AAD3.4010301@nortelnetworks.com>
Date: Wed, 14 Jan 2004 15:47:15 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Clay Haapala <chaapala@cisco.com>
Cc: Greg KH <greg@kroah.com>, Nuno Silva <nuno.silva@vgertech.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com>	<20040114171527.GB5472@kroah.com>	<40058086.5000106@nortelnetworks.com> <yqujn08q46ct.fsf@chaapala-lnx2.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clay Haapala wrote:

> Is the act of printing/syslogging a rule in an of itself? 

I haven't looked at the capabilities in a while.  Can you specify a 
default rule if nothing else matches?  Can you, in one rule, specify 
another rule?  (Kind of like iptables jump targets).

If so, then this would allow massive flexibility.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

