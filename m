Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTK2UZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTK2UZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:25:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:20707 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262790AbTK2UZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:25:58 -0500
Message-ID: <3FC90081.5090507@onlinehome.de>
Date: Sat, 29 Nov 2003 21:24:33 +0100
From: Marcus Hartig <marcush@onlinehome.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031122
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de> <20031129165648.GB14704@gtf.org>
In-Reply-To: <20031129165648.GB14704@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:823e08cba3fcdbae5a18972bf177a75c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Note that (speaking technically) the SII libata driver doesn't mask all
> interrupt conditions, which is why it's listed under CONFIG_BROKEN.  So
> this translates to "you might get a random lockup", which some users
> certainly do see.

However, I've also tested it with my new Maxtor SATA. And I must say:
Many thanks, well done! Now, I can use 2.6.0-test under fedora with
a fine speed ~ 50MB/s in disk reads.

And with GNOME2 under 2.6.0-test11: I can compile the kernel, watch a 
movie trailer, play 2 OpenGL screensavers, download an Knoppix ISO
and the desktop has a good performance, like there is nomore running.
Cool! <http://www.marcush.de/screen-2.6.jpg> (250kb)

Jeff, if you ever come to Germany, Hamburg, I will invite you for a good 
drink in a fine location. :-)


Greetings,

Marcus

