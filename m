Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVE3XG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVE3XG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVE3XG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:06:26 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:30359 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261810AbVE3XGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:06:20 -0400
Message-ID: <429B9BD0.7000004@keyaccess.nl>
Date: Tue, 31 May 2005 01:03:44 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Domen Puncer <domen@coderock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.12-rc2: Compose key doesn't work
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526154509.GB9443@animx.eu.org> <20050526155344.GB3694@ucw.cz>
In-Reply-To: <20050526155344.GB3694@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> On Thu, May 26, 2005 at 11:45:09AM -0400, Wakko Warner wrote:

>>I also have a problem with 2.6.12-rcX and ps/2 keyboard.  I would say it's
>>the same key we're talking about.  It does not work at the console nor in X
>>(showkey at the console does not see it).  It works with a USB keyboard.  My
>>"compose" is mapped to the menu key beside the right windows key.
>>
>>I do wish they'd fix it, because I use this key (kinda like another ALT key)
>>more than my compose key (again, the menu key, not the right win logo key)
> 
>  
> This patch should fix it.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ChangeSet@1.2229.1.9, 2005-04-04 15:37:45+02:00, vojtech@suse.cz
>   input: Fix fast scrolling scancodes in atkbd.c

ACK, thanks.

Rene.
