Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265186AbUD3SPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265186AbUD3SPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUD3SPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:15:17 -0400
Received: from mail2.webmessenger.it ([193.70.193.55]:30083 "EHLO
	mail1a.webmessenger.it") by vger.kernel.org with ESMTP
	id S265186AbUD3SPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:15:10 -0400
Message-ID: <40929785.6050807@copeca.dsnet.it>
Date: Fri, 30 Apr 2004 20:14:29 +0200
From: Giuliano Colla <copeca@copeca.dsnet.it>
Reply-To: colla@copeca.it
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031007
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Arthur Perry <kernel@linuxfarms.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it> <Pine.LNX.4.58.0404300947290.17408@tiamat.perryconsulting.net>
In-Reply-To: <Pine.LNX.4.58.0404300947290.17408@tiamat.perryconsulting.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Perry ha scritto:

>Hello,
>
>I have 2 parts to this IMHO exerpt.
>Top half is system level oriented in response to the hardware detection
>"issue", and the bottom half is in regard to the tainted kernel module
>load flag.
>
>Creating a hardware detection package for a distribution is not an
>incredibly difficult thing to do, since most of the tools that one needs is readily available.
>  
>
<snip>

I fully agree with you.

>Now about the "tainted" flag, the end user who is at the level of who
>needs this whole package is probably not going to know too much about what
>"tainted" means, or would not know that is is even there.
>  
>
In that case particular they may notice, because they would get too 
screenfull of errors, instead of just one!

>Professionals will be flagged, but I think they have a right to know.
>
>  
>
>I would want to know if a device driver that I have loaded is indeed a
>binary-type within a wrapper of some kind. That will give me an indication
>of what to expect. If I caught any wind of the vendor HIDING such things
>from me, because they want to make their device driver APPEAR to be just
>as native as the rest, then I would say that TAINTS the VENDOR'S
>REPUTATION in my eyes.
>You have to remember who you are trying to fool.
>
>  
>
You're right by the ethical point of view. But by practical point of 
view, if you're a professional you knew everything beforehand, when you 
dowloaded the piece of software, and had to accept an agreement which 
has nothing to do with GPL.

-- 
Ing. Giuliano Colla
Direttore Tecnico
Copeca srl
Bologna Italy 



