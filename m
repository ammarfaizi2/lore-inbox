Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJGMqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTJGMqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:46:34 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:8948 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id S262323AbTJGMqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:46:32 -0400
Message-ID: <3F82B5A6.2000203@debian.org>
Date: Tue, 07 Oct 2003 14:46:30 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: David Lang <david.lang@digitalinsight.com>,
       Krishna Akella <akellak@onid.orst.edu>, Paul Jakma <paul@clubi.ie>,
       kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
Subject: [OT] Re: Can't X be elemenated?
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell> <Pine.LNX.4.58.0309301316510.12484@dlang.diginsite.com> <20031007040449.GM205@openzaurus.ucw.cz> <3F82780C.8080408@pixelized.ch> <20031007121825.GA323@elf.ucw.cz>
In-Reply-To: <20031007121825.GA323@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2003 12:46:31.0119 (UTC) FILETIME=[084355F0:01C38CD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>>Do you want only one distribution for user, one for small companies, one 
>>for schools,...? Do you want only one web server implementation? Only one 
>>filesystem per task (only one journaling FS)?
>>Are they all "historical accident"?
> 
> 
> Well, I'm pretty glad there's only one glibc, 

only one glibc, but there are some implementation of libc. Also in this list we 
discuss about a tiny libc for init process, but you are right, it solve another 
problem (be small and simple). But from such discussion I worried to know that 
there exist so much implementation of libc.

> and only one http protocol, and only one X protocol.

You speak about protocols (but there are also incompatible extention), but you 
know that there exists a lot o toolkit to handle http links...

> And it would be way better if there
> was just one toolkit commonly used on Linux.

better? More efficient yes. But you know... GNU/Linux comunity will start a long 
(more years) flameware to choose the best solution, the best protocol,...
so IMHO it is good that we have different toolkits (so I think less flames, more 
work). But I agree that in long period we should switch to one toolkit (as we 
switched (nearly) all to glibc, xfree86 (but yet a new fork?), gcc(egcs style),...

BTW IIRC the discuttion was about qt and gtk. IIRC the KDE and gnome comunities 
are approaching methods and protocols, so in future maybe we will have only one 
toolkit, but not to correct an "historical accident" but because evolution.

ciao
	giacomo


