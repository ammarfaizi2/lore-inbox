Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTLJRpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTLJRpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:45:44 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:10510 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S263809AbTLJRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:45:35 -0500
Message-ID: <3FD75BB0.7030001@lougher.demon.co.uk>
Date: Wed, 10 Dec 2003 17:45:20 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: manningc2@actrix.gen.nz
CC: David Woodhouse <dwmw2@infradead.org>, joern@wohnheim.fh-wedel.de,
       kbiswas@neoscale.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [OT?]Re: partially encrypted filesystem
References: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net> <20031210010947.CA5875748@blood.actrix.co.nz>
In-Reply-To: <20031210010947.CA5875748@blood.actrix.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Manning wrote:
> On Tuesday 09 December 2003 02:44, phillip@lougher.demon.co.uk wrote:
>>Or maybe 'not in(to)-place' :-) I don't think I was saying compression is
>>difficult, it is not difficult if you've designed the filesystem correctly.
> 
> 
> Effectively saying that a fs that can't easily support compression is badly 
> designed is a dangerous over-simplfication/generalisation/slur. 
> 

Apologies all round to anyone who feels offended.  What I meant to say 
is compression is not that difficult if you design the filesystem from 
the outset with compression in mind - retro fitting compression to an 
existing filesystem, however, can be very difficult (especially 
compressed metadata), and that's why it's not a good idea.

The concept that all well designed filesystems should easily support 
compression is wrong, and I didn't intend to imply that.

Phillip

