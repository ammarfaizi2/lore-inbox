Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbSJHBjs>; Mon, 7 Oct 2002 21:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262636AbSJHBjs>; Mon, 7 Oct 2002 21:39:48 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:47245 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262632AbSJHBjr>; Mon, 7 Oct 2002 21:39:47 -0400
Message-ID: <3DA23998.6020004@easynet.be>
Date: Tue, 08 Oct 2002 03:49:12 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.5.41] Oops on reboot in device_remove_file
References: <Pine.LNX.4.44.0210071428260.16276-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Mon, 7 Oct 2002, Burton Windle wrote:
> 
> 
>>2.5.41, after "Rebooting..." is printed, I get this oops:
> 
> 
> There is a series of patches that I posted a few hours ago which should 
> solve this problem. I apologize; I forgot to state that they should fix 
> this Oops. It was reported a couple of days ago, as well..
> 
> If you're using BK, you can pull from
> 
> bk://ldm.bkbits.net/linux-2.5-ide
> 
> Or search the archives starting here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103401951632484&w=2
> 
> 
> If you're feeling adventurous, please apply them and let me know if they 
> fix the problem for you.
> 
> Thanks,
> 
> 	-pat
> 

Works for me, thanks.

Luc



