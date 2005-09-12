Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVILWuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVILWuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVILWuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:50:55 -0400
Received: from dvhart.com ([64.146.134.43]:62081 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932336AbVILWuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:50:54 -0400
Date: Mon, 12 Sep 2005 15:50:51 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: paolo.ciarrocchi@gmail.com, nish.aravamudan@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Message-ID: <212680000.1126565451@flay>
In-Reply-To: <4d8e3fd3050912140439c14518@mail.gmail.com>
References: <20050912024350.60e89eb1.akpm@osdl.org> <4d8e3fd305091208191fbbe804@mail.gmail.com> <29495f1d05091213134d917bd7@mail.gmail.com> <4d8e3fd3050912140439c14518@mail.gmail.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, September 12, 2005 23:04:47 +0200 Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:

> On 9/12/05, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>> On 9/12/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>> > On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
> [...]
>> > > 
>> > > - There are several performance tuning patches here which need careful
>> > >  attention and testing.  (Does anyone do performance testing any more?)
>> > 
>> > How about the tool announced months ago by Martin J. Bligh ?
>> > 
>> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>> 
>> Preferred location is: test.kernel.org (much shorter too!)
> 
> I wasn't aware of that, thank you! Now I won't forget anymore that URL ;-)
>  
>> Also, the problem for -mm3 is that -mm2 did not build on most
>> machines. -mm1 did on 4/6. Probably some determination could be made
>> from those.
> 
> I see. But I still think that automated testing is a great opportunity
> for the community to pinpoint problems.
> 
> Is there anything we can do to make thinks work better ?

Stop breaking kernels from compiling? ;-) If people tested their patches
before fixing them, would make it easier ...

Or as Nish suggested, fixing some of them helps. it's exhausting to try
to debug all of them myself. Yes, I'm aware that some require specific
hardware access, and are a pain in the butt ...

I can very easily test fixes that are sent to me as a straight patch 
URL on top of the kernel in question, anything else is a hassle (hint:
this ain't a full-time job for me ;-))

M.

