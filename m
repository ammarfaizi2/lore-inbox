Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVLNXkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVLNXkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVLNXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:40:13 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:19151 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965091AbVLNXkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:40:12 -0500
Message-ID: <43A0AD68.50107@tmr.com>
Date: Wed, 14 Dec 2005 18:40:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux-VServer ML <vserver@list.linux-vserver.org>
Subject: Re: [ANNOUNCE] second stable release of Linux-VServer
References: <20051213185650.GA6466@MAIL.13thfloor.at> <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 13 Dec 2005, Herbert Poetzl wrote:
> 
> 
>>Well, as the OpenVZ folks announced their release on LKML
>>I just decided to do similar for the Linux-VServer release,
>>so please let me know if that is not considered appropriate.
> 
> 
> Since there is a legitimate (and very popular) use case for
> virtuozzo / vserver functionality, I think it is a good
> thing to get all the code out in the open.
> 
> I really hope we will get something like BSD jail functionality
> in the Linux kernel.  It makes perfect sense for hosting
> environments.
> 
Like many needs there are lots of solutions, none of which are perfect, 
or at least without problems the competition says are important ;-) This 
is one more thing to study, but it seems as though there is not an 
overview of the various solutions for easy comparison.

This list is probably incomplete:
  linuxjail - BSD jail is the goal
  VMware - I use this for BSD machines
  xen - the last I looked ran Linux, not Windows or BSD unpatched
  UML - run Linux nicely
  VServer - news to me

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
