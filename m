Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUFCESP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUFCESP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265497AbUFCESO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:18:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46038 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265495AbUFCESK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:18:10 -0400
Message-ID: <40BEA673.8080301@pobox.com>
Date: Thu, 03 Jun 2004 00:17:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jkmaline@cc.hut.fi,
       james.p.ketrenos@intel.com
Subject: Re: wireless-2.6 queue opened
References: <40BE9ED8.9020505@pobox.com> <20040602211038.287628ac.davem@redhat.com>
In-Reply-To: <20040602211038.287628ac.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 02 Jun 2004 23:45:28 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Given that there are at least 3 complete wireless stacks (or 
>>thereabouts) floating about for Linux, I picked one that I felt had the 
>>best chance of being _evolved_ into a nice, clean, generic wireless 
>>stack:  HostAP.
> 
> 
> Even though I authored one of the "other" stacks, I'm totally fine
> with this choice.  Mainly because I simply lack the time or resources
> to continue working on the stack I started.


Actually...   I want to use some of your stuff too.  :)  HostAP is a 
successful implementation, but your stuff was a good example of the glue 
needed to tie 802.11 tightly to the net stack.

HostAP still has some "its a separate driver" stuff it needs to get rid 
of, as it is made more generic.

	Jeff


