Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUICQwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUICQwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269515AbUICQs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:48:57 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:4800 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269466AbUICQsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:48:03 -0400
Message-ID: <4138A03C.3030502@comcast.net>
Date: Fri, 03 Sep 2004 11:47:56 -0500
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
CC: Jean-Eric Cuendet <jec@rptec.ch>, linux-kernel@vger.kernel.org,
       zanussi@us.ibm.com
Subject: Re: Sun DTrace equivalent for Linux?
References: <41386AB5.6030406@rptec.ch> <Pine.LNX.4.60L.0409031643150.6546@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.60L.0409031643150.6546@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Milkowski wrote:

> On Fri, 3 Sep 2004, Jean-Eric Cuendet wrote:
> 
>> Hi,
>> I read an article on DTrace on Solaris. It seems wonderful. Is it 
>> overrated by Sun or really an excellent tool?
> 
> 
> It's really wonderful tool.
> The more you use it the more addicted to it you are :)
> 
>> Is there an equivalent tool for Linux?
> 
> 
> Equivalent - no.
> 
> Something much more simple - yes (LTT, DProbes, ...)
> 
> 

Though it was meant mainly to address the specific topic of that thread, 
I recently posted a simple add-on to the LTT user tools that shows what 
can be done with the existing Linux stuff e.g. LTT and kprobes:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109405724500237&w=2

It basically makes LTT more amenable to the type of ad-hoc 
experimentation people seem to like about DTrace.

Tom
