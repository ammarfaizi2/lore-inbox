Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSH1B44>; Tue, 27 Aug 2002 21:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSH1B4z>; Tue, 27 Aug 2002 21:56:55 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:39690 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S318562AbSH1B4z>;
	Tue, 27 Aug 2002 21:56:55 -0400
Message-ID: <3D6C2EE6.4000906@acm.org>
Date: Tue, 27 Aug 2002 21:01:10 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] IPMI driver for Linux
References: <3D63B612.8020706@acm.org> <20020827145512.K35@toy.ucw.cz> <20020827151401.H23434@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:

>The "Intelligent Perhiperal Management Interface".  It's a managment system
>for communicating to intelligent or semi-intelligent devices on a separate
>communication channel from the 'typical' data paths.
>
>I think you can download the specs from the Intel web site.
>
It's at http://www.intel.com/design/servers/ipmi/index.htm.  Note that 
many people are doing things far beyond what the spec says in multi-card 
chassis like CompactPCI and PICMG2.16.  Someone mentioned earlier that I 
must have access to documentation they don't have, I just know stuff 
lots of people are doing.

-Corey



