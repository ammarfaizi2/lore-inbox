Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUDKVFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUDKVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 17:05:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262488AbUDKVFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 17:05:37 -0400
Message-ID: <4079B313.7010907@pobox.com>
Date: Sun, 11 Apr 2004 17:05:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Ga?l Le Mignot <kilobug@freesurf.fr>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: Any plan for inclusion of linux-wlan-ng ?
References: <plopm3lll26bsg.fsf@drizzt.kilobug.org> <20040411164011.GA21257@kroah.com>
In-Reply-To: <20040411164011.GA21257@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Apr 11, 2004 at 12:37:03PM +0200, Ga?l Le Mignot wrote:
> 
>>Hello,
>>
>>I was just  wondering is there is any  plan of including linux-wlan-ng
>>into  the 2.6  kernel. Does  someone know  about that  ? If  not, does
>>someone know why ?
> 
> 
> The authors have never submitted it?  Or wanted to?

Never submitted AFAIK, but regardless...

There is a central problem of multiple 802.11 stacks that I very much 
want to avoid.  linux-wlan-ng, HostAP, madwifi, and one or two others.

I had hoped that HostAP would be submitted, and that could form the 
basis of a common 802.11 stack, but I haven't heard anything about that 
in many weeks.

	Jeff



