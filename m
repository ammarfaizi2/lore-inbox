Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWIDK1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWIDK1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWIDK1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:27:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:20237 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751367AbWIDK1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:27:21 -0400
Message-ID: <44FC0061.1000007@sw.ru>
Date: Mon, 04 Sep 2006 14:30:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: =?windows-1251?Q?Fernando_Luis_V=E1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>
CC: Greg KH <gregkh@suse.de>, Greg KH <greg@kroah.com>,
       "Luck, Tony" <tony.luck@intel.com>, akpm@osdl.org, dev@openvz.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, stable@kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
       xemul@openvz.org
Subject: Re: [stable] [PATCH] Linux 2.6.17.11 - fix compilation error on	IA64
 (try #3)
References: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com>	 <20060829013137.GA27869@kroah.com> <44F431F5.7020703@sw.ru>	 <20060829160841.GB9078@suse.de> <1157364634.3162.8.camel@sebastian.intellilink.co.jp>
In-Reply-To: <1157364634.3162.8.camel@sebastian.intellilink.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando,

I planned to send it today. You will be on CC

Thanks,
Kirill

> On Tue, 2006-08-29 at 09:08 -0700, Greg KH wrote:
> 
>>On Tue, Aug 29, 2006 at 04:24:21PM +0400, Kirill Korotaev wrote:
>>
>>>Probably it is my fault, since I thought that patches which got into -stable
>>>automatically go into Linus tree.
>>
>>No they do not.  Usually it's the requirement that they be in his tree
>>first, but I didn't think it was necessary this time due to my
>>misunderstanding about the fix.
> 
> 2.6.18-rc6 has just been released and neither my patch nor the original
> patch to which it is a fix seem to have been included. Does this mean
> they will not be sent to Linux before the final release of 2.6.18?
> 
> Regards,
> 
> Fernando
> 
> 


-- 
VGER BF report: H 0
