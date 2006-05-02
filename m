Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWEBQVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWEBQVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWEBQVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:21:43 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:57361 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964898AbWEBQVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:21:42 -0400
Message-ID: <44578712.9030403@argo.co.il>
Date: Tue, 02 May 2006 19:21:38 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Brian Beattie <brianb@apcon.com>
CC: Martin Mares <mj@ucw.cz>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com>	 <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>	 <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il>	 <mj+md-20060502.111446.9373.atrey@ucw.cz>  <445741F5.6060204@argo.co.il> <1146586613.3313.12.camel@brianb>
In-Reply-To: <1146586613.3313.12.camel@brianb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 16:21:40.0867 (UTC) FILETIME=[7E8C0D30:01C66E04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Beattie wrote:
> On Tue, 2006-05-02 at 14:26 +0300, Avi Kivity wrote:
>
>   
>> There are C++ embedded kernels in http://www.zipworld.com.au/~akpm/ and 
>> http://ecos.sourceware.org/, but I haven't looked at them, so I can't 
>> say whether I consider them nice or not.
>>     
>
> You keep saying the eCos is written in C++, I see no evidence of that.
>   

Someone posted in on this thread; I have no prior experience with it.

However, this may satisfy you:

http://ecos.sourceware.org/cgi-bin/cvsweb.cgi/ecos/packages/kernel/current/src/sched/sched.cxx?rev=1.18&content-type=text/x-cvsweb-markup&cvsroot=ecos

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

