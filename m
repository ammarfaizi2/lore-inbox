Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTFYVVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTFYVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:21:48 -0400
Received: from dm2-55.slc.aros.net ([66.219.220.55]:58560 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265086AbTFYVVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:21:42 -0400
Message-ID: <3EFA15B6.9000504@aros.net>
Date: Wed, 25 Jun 2003 15:35:50 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Anyone for NBD maintainer [was Re: [RFC][PATCH] nbd driver for
 2.5+: fix locking issues with ioctl UI]
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625175849.GB4988@elf.ucw.cz> <3EF9E83C.6030504@aros.net> <20030625183045.GD4988@elf.ucw.cz>
In-Reply-To: <20030625183045.GD4988@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>> . . .I'd be honoured too but not sure what exactly that entails. What other 
>>stuff would I have to do besides actively developing it? I won't be able 
>>to do anything on the Internet till Monday either.
>>    
>>
>
>Well, maintainer gets patches from people and should decide which are
>good and which are not...
>
>Anyway if you give me your sf.net name, I can probably add you as a
>developer to the nbd.sf.net... but: I'd like you to keep userland code
>backward compatible. Ie. new userland code should still work with
>2.4.x kernel.
>								Pavel
>  
>
Okay. Haven't heard anyone say lose the compatibility in favor of the 
cleanup so I'll work on the back compatibility more in the driver. Same 
with userland tools. I'd better get a sf.net name then apparantly. 
Thanks ;-)

