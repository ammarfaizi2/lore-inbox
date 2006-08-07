Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWHGHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWHGHXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWHGHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:23:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:18970 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751124AbWHGHXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:23:14 -0400
Message-ID: <44D6EA68.7060001@sw.ru>
Date: Mon, 07 Aug 2006 11:23:20 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Shailabh Nagar <nagar@watson.ibm.com>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, haveblue@us.ibm.com, pj@sgi.com,
       saw@sawoct.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D372F5.5000901@sw.ru> <44D37A8C.4000608@watson.ibm.com> <20060804170310.GA11904@in.ibm.com>
In-Reply-To: <20060804170310.GA11904@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Fri, Aug 04, 2006 at 12:49:16PM -0400, Shailabh Nagar wrote:
> 
>>>BTW, to help to compare (as you noted above) here is the list of 
>>>features provided by OpenVZ:
>>>
>>
>>Could you point to a place where we can get a broken-down set of
>>patches for OpenVZ or (even better), UBC ?
>>
>>For purposes of the resource management discussion, it will be
>>useful to be able to look at the UBC patches in isolation
>>and perhaps port them over to some common interface for testing
>>comparing with other implementations.
> 
> 
> Kirill,
> 
> Is this the latest set (based on your last publication) for
> people to look at ?
> 
> http://download.openvz.org/kernel/broken-out/2.6.16-026test005.1/
it is quite recent. all the patches diff-ubc-*
here you can find a tool for UBC control ubctl.c:
http://download.openvz.org/contrib/utils/

Kirill
