Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTLCJaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 04:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTLCJaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 04:30:11 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:44400 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264516AbTLCJaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 04:30:08 -0500
Message-ID: <3FCDAD1D.5080001@myrealbox.com>
Date: Wed, 03 Dec 2003 10:30:05 +0100
From: Jonathan Fors <etnoy@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031124
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Jin Suh <jinssuh@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test11]: It doesn't boot with a bootcd
References: <20031202213548.80808.qmail@web41211.mail.yahoo.com>
In-Reply-To: <20031202213548.80808.qmail@web41211.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you booting with Lilo? Then you could try to pass the vga=normal 
parameter to the bootloader in lilo.conf . I'm not sure with Grub, but I 
bet somebody else here is.

If you let the booting progress continue blind-headed, can you login or 
wait for X to start? It's possible that the system actually boots, just 
that you don't see it.

Jonathan

Jin Suh wrote:

>With framebuffer option on, it went to out ot range on my monitor shortly after
>I see Loading Linux.... and about 10 lines of boot messages (couldn't read the
>messages).
>Without framebuffer option, my monitor goes to a messed-up color right after I
>see Loading Linux... and few other lines. 
>
>Thanks,
>Jin
>
>  
>

