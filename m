Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTJDQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJDQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:26:48 -0400
Received: from mail1.dac.neu.edu ([129.10.1.75]:1796 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id S262465AbTJDQ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:26:47 -0400
Message-ID: <3F7EF4A0.7060504@ccs.neu.edu>
Date: Sat, 04 Oct 2003 12:26:08 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise> <20031003223352.GB344@elf.ucw.cz> <3F7E57E9.8070904@ccs.neu.edu> <20031004080239.GA213@elf.ucw.cz>
In-Reply-To: <20031004080239.GA213@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>+ *    Note: The buffer we allocate to use to write the suspend header is
>>>+ *    not freed; its not needed since system is going down anyway
>>>+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
>>>+ */
>>
>>Too lazy to properly fix your comment as well.
> 
> 
> Can you elaborate?
> 								Pavel

Pavel what mail client are you using?  The last comment
reads:
+ *    (plus it causes oops and I'm lazy<CTRL-H><CTRL-H><CTRL-H><CTRL-H>too busy).

I spelled out the ^H so you can see them, that is how
the comment looks to me.  The word 'lazy' is still in
there along with too busy, you never backspaced over
the lazy in the comment.  That's all :P

-sb


