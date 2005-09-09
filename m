Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVIIW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVIIW1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVIIW1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:27:14 -0400
Received: from mail-out2.fuse.net ([216.68.8.175]:36240 "EHLO smtp2.fuse.net")
	by vger.kernel.org with ESMTP id S932587AbVIIW1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:27:14 -0400
Message-ID: <4321643A.9060008@fuse.net>
Date: Fri, 09 Sep 2005 06:30:18 -0400
From: rob <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: swsusp
References: <431E97E5.1080506@fuse.net> <431F42D0.6080304@gmail.com> <4321179B.6080107@fuse.net> <4321C7FF.8030109@gmail.com> <43215470.3020502@fuse.net> <432201CB.2090109@gmail.com>
In-Reply-To: <432201CB.2090109@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:

>
>> I see it as a good thing it hasen't ben included in the kernel tree
>> -
>
>
> Strange...
> Since documentation available in site and in 
> Documentation/power/suspend2.txt.
>
> And that many people with laptops uses it...
>
> But everyone with his problems :)
>
> Alon.
>
all of that assumes that the kernel boots not one word about kernel 
configuration
(as far as what may interfeaf with it working it dosen't say wether or 
not it needs swsusp
turned on I tryed it with swsusp on and off same thing )
not one word about troble shooting the olny thing about it that did work 
for me was that
the patch applyed to the 2.6.13 kernel source I can't even get the 
kernel to build with
swsusp2 turned off on a patched kernel source

this is veary veary alpha it compiles and thats as far as I can get with it

OK it works for you I'm not willing to put anymore effort in to it
