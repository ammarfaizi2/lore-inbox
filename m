Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTFPWlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTFPWjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:39:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17062 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264399AbTFPWi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:38:29 -0400
Message-ID: <3EEE4A1A.6010904@pobox.com>
Date: Mon, 16 Jun 2003 18:52:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Janice M Girouard <janiceg@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Janice Girouard <girouard@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, kenistonj@us.ibm.com
Subject: Re: patch for common networking error messages
References: <3EEE28DE.6040808@us.ibm.com> <20030616.133841.35533284.davem@redhat.com> <3EEE2F9F.60706@us.ibm.com> <3EEE492E.9080308@pobox.com>
In-Reply-To: <3EEE492E.9080308@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 3) _Somebody_ needs to do some "ground pounding", and figure out what 
> info sysadmins and users want to see.  Event logging in general, so far, 
> seems to me more like a management checklist item than a real user 
> need... but I am quite willing to be proved wrong.  Until we get 
> feedback along these lines, I tend to resist changes like this in 
> general.  My initial read of your attached patch was that it was a long 
> of source churn, and I couldn't fathom what any user would gain from it 

make that "a lot of"


> There are a whole bunch of netif_msg_xxx and corresponding NETIF_MSG_xxx 
> bits.  I don't see much need to change that I think getting the logging 
> API right for those would be an important first step.
> 
>     Jeff

arg :)  I should fire my editor.

	Jeff



