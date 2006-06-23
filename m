Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWFWOFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFWOFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFWOFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:05:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21942 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750720AbWFWOFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:05:45 -0400
Message-ID: <449BF508.9040207@draigBrady.com>
Date: Fri, 23 Jun 2006 15:04:56 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
       Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
In-Reply-To: <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 22 Jun 2006, Linus Torvalds wrote:
> 
> 
>>On Thu, 22 Jun 2006, Junio C Hamano wrote:
>>
>>> - diff --color (Johannes).
>>
>> - default to red/green for old/new lines. That's the norm, I'd think.
> 
> 
> ... and which happens to be useless for 10% of the male population (and 
> even more if you look specifically at Asian people). But then, I just 
> pasted that part from somewhere else.

:)

So 10% of the male population need to learn
traffic light positions rather than colours?

I'm red/green colour blind which means I can't
distinguish _subtley_ different shades of red and green.

vim is another fondue fork offender as it merges
syntax highlighting and diff colours in diff mode (vimdiff).
I put the following in ~/.vimrc to disable that madness:

if &diff
    "I'm only interested in diff colours
    syntax off
endif

Pádraig.
