Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTKZRyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKZRyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:54:20 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:18316
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264299AbTKZRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:54:18 -0500
Message-ID: <3FC4E8C8.4070902@free.fr>
Date: Wed, 26 Nov 2003 18:54:16 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 26 Nov 2003, Vince wrote:
>>parameter LOG_BUF_LEN. Some people required 32 kB. But you shouldn't
>>exceed 60 kB since the dump is done in real mode (16 bits).
>>For kernel versions 2.5.6x and later, the LOG_BUF_LEN parameter is part
>>of the kernel .config file (LOG_BUF_SHIFT) so you don't need to modify
>>it at all.
>>---------------------------------
>>
>>...so I you think 60kB would be enough to catch the first oops -- or if
>>the doc is outdated -- I can try this...
> 
> 
> *groan* do you have a PDA?
> 

Nope. I could probably borrow a laptop to a friend but am not excited at 
the idea of having to setup some serial console thing (I do not even 
have a serial cable). Dump to floppy/swap/disk would be much easier in 
my case... if it could me made to work, of course ;-)

