Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWFGOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWFGOmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFGOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:42:19 -0400
Received: from fmr18.intel.com ([134.134.136.17]:12690 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932240AbWFGOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:42:18 -0400
Message-ID: <4486E572.4040201@intel.com>
Date: Wed, 07 Jun 2006 07:40:50 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Auke Kok <sofar@foo-projects.org>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Subject: Re: [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644A2.7000208@jp.fujitsu.com> <44865FD8.4060801@foo-projects.org> <448682B6.5010302@jp.fujitsu.com>
In-Reply-To: <448682B6.5010302@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige wrote:
> Auke Kok wrote:
>> Kenji Kaneshige wrote:
>>
>>> This patch makes Intel e1000 driver legacy I/O port free.
>>>
>>> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>>
>> (adding netdev and the other e1000 maintainers to cc:)
>>
>> without sending this to any of the listed e1000 maintainers???? *and* 
>> not even including netdev???
>>
> 
> I'm sorry about that.

I also didn't see that you were sending this to Greg-KH. I think I got thrown 
off by that as I wasn't following lkml until yesterday in the first place. 
I'll toss the patches around over here and see what comes up.

Cheers,

Auke

