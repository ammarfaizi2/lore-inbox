Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVEXP03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVEXP03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVEXPWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:22:34 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:57735 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262096AbVEXPVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:21:34 -0400
Message-ID: <42934674.30406@yahoo.com.au>
Date: Wed, 25 May 2005 01:21:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <42930E79.1030305@cybsft.com>
In-Reply-To: <42930E79.1030305@cybsft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:

> 
> There are definitely those who would prefer to have the functionality,
> at least as an option, in the mainline kernel. The group that I contract
> for get heartburn about having to patch every kernel running on every
> development workstation and every production system. We need hard RT,
> but currently when we have to have hard RT we go with a different
> product.

Well, yes. There are lots of things Linux isn't suited for.
There are likewise a lot of patches that SGI would love to
get into the kernel so it runs better on their 500+ CPU
systems. My point was just that a new functionality/feature
doesn't by itself justify being included in the kernel.org
kernel.

> Another thing that some of us want/need is a hard real-time
> Linux that doesn't create the segregation that most of these specialized
> products create. Currently there are damn few choices for real posix
> applications development with hard RT requirements running in a Unix
> environment.
> 

Maybe there are damn few because it is hard to get right within
the framework of a general posix environment. Or maybe its
because it has a comparatively small userbase (compared to say
mid/small servers and desktops). Which are neither completely
invalid reasons against its inclusion in Linux.

But I want to be clear that I haven't read or thought about the
code in question too much, and I don't have any opinions on it
yet. So please nobody involve me in a flamewar about it :)

Nick

