Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUHDT4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUHDT4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUHDT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:56:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:13004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267385AbUHDT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:56:38 -0400
Date: Wed, 4 Aug 2004 12:56:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: James Morris <jmorris@redhat.com>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
In-Reply-To: <1091647612.24215.12.camel@ghanima>
Message-ID: <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
 <1091644663.21675.51.camel@ghanima> <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
 <1091647612.24215.12.camel@ghanima>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Aug 2004, Fruhwirth Clemens wrote:
> 
> I don't view the FSF as sort of last instance, but just for the
> protocol: The exact wording of this license is labeled 'GPL-compatible'
> by the FSF. Imho, this makes it a subset.

Ahh. Fair enough. I didn't have any lawyer look at it, I just don't like 
assuming.

> Additional coding, no problem, but additional social work, I'd prefer
> not to be involved with. As there is no legal requirement, such efforts
> would just make a good appearance.

I'd much rather do the social work, not so much necessarily for legal 
reasons, but for my own menal well-being. It's just _so_ much nicer to 
work with a code-base where none of the authors might complain about being 
included.

So even if the original license is GPL-compatible, just the fact that Jari 
doesn't want his work re-licensed means that I don't want his work in the 
kernel - whether it's a legal issue or not. 

Now, I obviously believe that Jari has acted like an ass, since he has
used the very same code under the GPL before, but hey, that's his problem. 

Jari - please stop distributing your loop-aes patches. If you consider the 
license to be non-GPL-compatible, then you have no business distributing 
the thing as kernel patches. Alternatively, just say it's GPL'd. You can't 
have it both ways.

		Linus
