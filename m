Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269838AbUIDIZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269838AbUIDIZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269836AbUIDIZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:25:51 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:16289 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269835AbUIDIZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:25:49 -0400
Message-ID: <41397C08.1020507@tungstengraphics.com>
Date: Sat, 04 Sep 2004 09:25:44 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>, Alex Deucher <alexdeucher@gmail.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <Pine.LNX.4.58.0409040107190.18417@skynet>  <a728f9f904090317547ca21c15@mail.gmail.com>  <Pine.LNX.4.58.0409040158400.25475@skynet>  <9e4733910409032051717b28c0@mail.gmail.com>  <Pine.LNX.4.58.0409040548490.25475@skynet> <9e47339104090323047b75dbb2@mail.gmail.com> <41397086.3020509@tungstengraphics.com> <Pine.LNX.4.58.0409040852090.25475@skynet>
In-Reply-To: <Pine.LNX.4.58.0409040852090.25475@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>>drm/linux is GPL licensed.
>>
>>This just isn't true.  What on earth makes you think this?  Read the license
>>before you make these sorts of comments, you dweeb.  There shouldn't be any
>>GPL code in there at all.
> 
> 
> I think you mis-read Keith, he said about converting it in the future to
> that form. I'm as I said against the GPL'ing of any of this at this stage,
> we have all the info we need in X DDXes they are all usually X licensed so
> I don't for see issues with ripping the code from them..

OK, it's a proposal rather than a statement.  Apologies in that case.

Let me be clear that I am unwilling to support changes to the DRM that break 
it's usability on other operating systems on principle.

Maybe it's time to consider a fork of the DRM to allow a major experimentation 
of the form Jon envisages to proceed without worrying about boring constraints 
like keeping BSD working, backwards compatibility, etc.  And the current DRM 
architecture, which is pretty much stabilized, can continue to do those boring 
tasks, and accumulate new drivers, until GNULonghorn is finished...

Keith
