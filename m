Return-Path: <linux-kernel-owner+w=401wt.eu-S1752950AbWLORMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbWLORMm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbWLORMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:12:42 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:48225 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbWLORMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:12:41 -0500
Date: Fri, 15 Dec 2006 09:13:26 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>,
       jesper.juhl@gmail.com, akpm <akpm@osdl.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-Id: <20061215091326.4d121119.randy.dunlap@oracle.com>
In-Reply-To: <4582B11C.9070305@s5r6.in-berlin.de>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
	<20061215120942.GA4551@ucw.cz>
	<4582AEC8.7030608@s5r6.in-berlin.de>
	<20061215142206.GC2053@elf.ucw.cz>
	<4582B11C.9070305@s5r6.in-berlin.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 15:28:44 +0100 Stefan Richter wrote:

> Pavel Machek wrote:
> >> Pavel Machek wrote:
> >> >> From: Randy Dunlap <randy.dunlap@oracle.com>
> >> >> +Use one space around (on each side of) most binary and ternary operators,
> >> >> +such as any of these:
> >> >> +	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> >> > 
> >> > Actually, this should not be hard rule.
> [...]
> > sometimes grouping around operator is useful,
> [...]
> 
> I agree.
> 
> By the way, the longer CodingStyle becomes, the less people will read it.

That's a good point IMO.

Maybe we could just summarize it with something like:

Use spaces around binary operators for readability but not to imply
any kind of grouping.

But I suppose that Pavel doesn't agree with that.  Oh well.

---
~Randy
