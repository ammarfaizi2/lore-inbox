Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270705AbRHWXS6>; Thu, 23 Aug 2001 19:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRHWXSs>; Thu, 23 Aug 2001 19:18:48 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:39943 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S270705AbRHWXSd>;
	Thu, 23 Aug 2001 19:18:33 -0400
Message-ID: <3B858F58.1000606@nothing-on.tv>
Date: Fri, 24 Aug 2001 00:18:48 +0100
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010817
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: Fred <fred@arkansaswebs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
In-Reply-To: <01082316383301.12104@bits.linuxball> <9m41qd$290$1@sisko.my.home> <01082318132000.12319@bits.linuxball>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred wrote:
> so why dos my filesystem have a 2 GB limit?
> Must I specify a large block size or some such when i format?
> 
> i run 2.4.9 on redhat7.1 out of the box
> 
Does it?  Unless RH are using a seriously old glibc (which I doubt) 
there's no 2GB limit any more.

Some older applications don't work with it AFAIK... anything bundled 
with a modern distro shouldn't have any problems.

Tony

