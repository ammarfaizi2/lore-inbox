Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUAYT5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbUAYT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:57:16 -0500
Received: from opersys.com ([64.40.108.71]:1296 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265213AbUAYT5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:57:11 -0500
Message-ID: <4014209E.2040908@opersys.com>
Date: Sun, 25 Jan 2004 15:01:34 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Cooperative Linux
References: <20040125193518.GA32013@callisto.yi.org>
In-Reply-To: <20040125193518.GA32013@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Aloni wrote:
> The bottom line is that it allows us to run Linux on an unmodified
> Windows 2000/XP system in a practical way (the user just launches 
> an app), and it may eventually bring Linux to a large sector of desktop 
> computer users who wouldn't even care about trying to install a 
> dual boot system or boot a Linux live CD (like Knoppix).
> 
> Screen-shots and further details at:
> 
>     http://www.colinux.org

Cool!

> Our motto is:
> 
>     "If Linux runs on every architecture, why should another 
>      operating system be in its way?"

Indeed.

> coLinux is similar to plex86 in a way that it implements a Linux-specific 
> lightweight VM with I/O virtualization. However, it is designed to be 
> mostly host-OS independent, so that with minimal porting efforts it 
> would be possible to run it under Solaris, Linux itself, or any operating 
> system that supports loading kernel drivers, under any architecture that 
> uses an MMU. Unlike other virtualization methods, it doesn't base its 
> implementation on exceptions that are caused by instructions. 

Right, that's the way to go with an OS for which the source is available.
Have you looked at the work that's been going on with the Adeos nanokernel:
http://www.opersys.com/adeos/index.html
Some of the infrastructure required by all these virtualization solutions
is fairly similar.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

