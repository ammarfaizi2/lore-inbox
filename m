Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265707AbSKAS5r>; Fri, 1 Nov 2002 13:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSKAS5r>; Fri, 1 Nov 2002 13:57:47 -0500
Received: from main.gmane.org ([80.91.224.249]:55699 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265707AbSKAS5p>;
	Fri, 1 Nov 2002 13:57:45 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Fri, 01 Nov 2002 14:05:14 -0500
Message-ID: <apuj4s$e33$1@main.gmane.org>
References: <20021101085148.E105A2C06A@lists.samba.org> <1036175565.2260.20.camel@mentor>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036177373 14435 130.127.121.177 (1 Nov 2002 19:02:53 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Fri, 1 Nov 2002 19:02:53 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:

> 
> On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
>> I'm down to 8 undecided features: 6 removed and one I missed earlier.
> 
> How about Olaf Dietsche's filesystem capabilities support? It has been
> posted a couple times to LK, yesterday even.
> 
> 
> We've had capabilities for ages (2.2?) but no filesystem support.
> 
> OpenBSD is recently bragging about no longer having any SUID root
> binaries on the system.
> 
> With FS capabilities we (Linux) can have the same situation.  Security
> is a hot topic, and anything the kernel can do make security
> better/easier seems worthy of consideration.
> 

Unfortunately Alexander has spoken again:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103498212701476&w=4

You might want to check out some of the other reviews, I don't think people 
gave it very high marks.

Cheers,
Nicholas


