Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVDHQRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVDHQRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVDHQQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:16:21 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:10462 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262864AbVDHQP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:15:26 -0400
Message-ID: <4256AE0D.201@tiscali.de>
Date: Fri, 08 Apr 2005 18:15:09 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 8 Apr 2005, Andrea Arcangeli wrote:
>  
>
>>Why not to use sql as backend instead of the tree of directories?
>>    
>>
>
>Because it sucks? 
>
>I can come up with millions of ways to slow things down on my own. Please 
>come up with ways to speed things up instead.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
SQL Databases like SQLite aren't slow.
But maybe a Berkeley Database v.4 is a better solution.

Matthias-Christian Ott
