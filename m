Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946673AbWKAHol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946673AbWKAHol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946674AbWKAHol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:44:41 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:18571 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946673AbWKAHok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:44:40 -0500
Message-ID: <45485046.6080508@in.ibm.com>
Date: Wed, 01 Nov 2006 13:14:06 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>	 <4545FDCD.3080107@in.ibm.com>	 <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>	 <454782D2.3040208@in.ibm.com>	 <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>	 <4548472A.50608@in.ibm.com> <6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
In-Reply-To: <6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 10/31/06, Balbir Singh <balbir@in.ibm.com> wrote:
>> I thought this would be hard to do in general, but with a page -->
>> container mapping that will come as a result of the memory controller,
>> will it still be that hard?
> 
> I meant that it's pretty much impossible with the current APIs
> provided by the kernel. That's why one of the most useful things that
> a memory controller can provide is accounting and limiting of page
> cache usage.
> 
> Paul

Thanks for clarifying that! I completely agree, page cache control is
very important!

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
