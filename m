Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTHVMbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTHVMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:31:45 -0400
Received: from mail-09.iinet.net.au ([203.59.3.41]:9229 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263116AbTHVLOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:14:40 -0400
Date: Fri, 22 Aug 2003 19:18:23 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Tim Hockin <thockin@sun.com>
cc: autofs@linux.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] autofs and namespaces
In-Reply-To: <3F43F442.20404@sun.com>
Message-ID: <Pine.LNX.4.44.0308221905080.4601-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tim,

Fact is that I am just now starting to look at 2.6 and the issues relating 
to it wrt autofs.

Perhaps you (or someone else) could help by giving me a 5 cent tour of the 
issues as you see them.

On Wed, 20 Aug 2003, Tim Hockin wrote:

> For lack of clear insight into this, I thought I might put this out for 
> opinions.
> 
> We're examining autofs and issues customers are having with it.  One of 
> the issues that came up during discussions of things we can do is 
> namespaces.

Customers are having trouble with it.

One of them would be me.

As you have seen on the autofs list I have been working to improve Sun 
<-> Linux automount integration for some time now and while I don't have a 
complete solution I have made significant progress, in an operational 
sense.

With luck and effort I expect to have a release available soonish.

> 
> Does anyone have any ideas how namespaces and autofs ought to play 
> together?  There are some obvious answers, but it seems to me that they 
> might not be correct.

This sounds very interesting but I am deep into getting an operational 
release for the 2.4 kernel right now. Anything I can do, at least for a 
while, will be a cursory survey.

> 
> Anyone out there want to throw some ideas out?  We can just ignore it, 
> but that isn't exactly nice.  What we really need is some guidance on 
> what kind of sematics are "correct".

Don't want to ignore it but ....

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

