Return-Path: <linux-kernel-owner+w=401wt.eu-S1752621AbWLOPEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbWLOPEm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWLOPEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:04:42 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:46522 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbWLOPEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:04:41 -0500
Message-ID: <4582B987.7030204@s5r6.in-berlin.de>
Date: Fri, 15 Dec 2006 16:04:39 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Scott Preece <sepreece@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, jesper.juhl@gmail.com,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH/v2] CodingStyle updates
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>	 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de>	 <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
In-Reply-To: <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Preece wrote:
> I think the mistake illuminates why parentheses should be the rule. If
> you're thinking about using spacing to convey grouping, use
> parentheses instead...

But then, we do reflect operator precedence by omitting whitespace
around . and ->, before [], or after unary & and *.
-- 
Stefan Richter
-=====-=-==- ==-- -====
http://arcgraph.de/sr/
