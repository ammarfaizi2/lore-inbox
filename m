Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSKCRrk>; Sun, 3 Nov 2002 12:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSKCRrk>; Sun, 3 Nov 2002 12:47:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262243AbSKCRrj>;
	Sun, 3 Nov 2002 12:47:39 -0500
Message-ID: <3DC56270.8040305@pobox.com>
Date: Sun, 03 Nov 2002 12:52:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jos Hulzink <josh@stack.nl>
CC: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Petition against kernel configuration options madness...
References: <200211031809.45079.josh@stack.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:

>It took me about an hour to find out why my keyboard didn't work in 2.5.45. 
>Well... after all it seemed that I need to enable 4 ! options inside the 
>input configuration, just to get my default, nothing special PS/2 keyboard up 
>and running. Oh, and I didn't even have my not so fancy boring default PS/2 
>mouse configured then. Guys, being able to configure everything is nice, but 
>with the 2.5 kernel, things are definitely getting out of control IMHO.
>  
>

This is potentially becoming a FAQ...  I ran into this too, as did 
several people in the office.  People who compile custom kernels seem to 
run into this when they first jump into 2.5.x.  AT Keyboard support is 
definitely buried :/

Unfortunately I don't have any concrete suggestions for Vojtech (input 
subsystem maintainer), just a request that it becomes easier and more 
obvious how to configure the keyboard and mouse that is found on > 90% 
of all Linux users computers [IMO]...

    Jeff




