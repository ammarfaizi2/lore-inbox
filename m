Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTJIUar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTJIUar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:30:47 -0400
Received: from natsmtp01.rzone.de ([81.169.145.166]:3754 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262465AbTJIUap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:30:45 -0400
Message-ID: <3F85C549.9050207@softhome.net>
Date: Thu, 09 Oct 2003 22:30:01 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Usage for particular User Login
References: <EMjk.4Ok.33@gated-at.bofh.it> <EPgT.Hl.3@gated-at.bofh.it>
In-Reply-To: <EPgT.Hl.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
>>You can also run a lot of top programs, each for one user (type 'u' 
>>while in top).
>>
>>Regards,
>>Nuno Silva
> 
> 
> nb. is their a way to get fair 'equal time / proc percentage per user' 
> queueing of the CPU(s).
> 
> i.e. not limiting the number of processes/user but limiting the total CPU 
> 'power' in use by a given user, something like the CBQ network 
> schedulers... perhaps with some classes (like root) more priveledged 
> etc... or is this something for 2.7?
> 

   Cannot be sure - but try to google in direction of "vserver linux".
   Digging into the lkml archives on vserver can give you some pointers.
   At least some posters were hinting that vserver has capability to 
limit CPU usage of given task.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

