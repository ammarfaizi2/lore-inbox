Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDDUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDDUyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDDUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:53:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32739 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261391AbVDDUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:47:58 -0400
Message-ID: <4251A7E8.6050200@pobox.com>
Date: Mon, 04 Apr 2005 16:47:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
CC: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org,
       Jes Sorensen <jes@trained-monkey.org>, linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <42519BCB.2030307@pobox.com> <20050404202706.GB3140@pegasos>
In-Reply-To: <20050404202706.GB3140@pegasos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther wrote:
> On Mon, Apr 04, 2005 at 03:55:55PM -0400, Jeff Garzik wrote:
> 
>>Matthew Wilcox wrote:
>>
>>>On Mon, Apr 04, 2005 at 10:51:30AM -0700, Greg KH wrote:
>>>
>>>
>>>>Then let's see some acts.  We (lkml) are not the ones with the percieved
>>>>problem, or the ones discussing it.
>>>
>>>
>>>Actually, there are some legitimate problems with some of the files in
>>>the Linux source base.  Last time this came up, the Acenic firmware was
>>>mentioned:
>>>
>>>http://lists.debian.org/debian-legal/2004/12/msg00078.html
>>>
>>>Seems to me that situation is still not resolved.
>>
>>And it looks like no one cares enough to make the effort to resolve this...
>>
>>I would love an open source acenic firmware.
> 
> 
> Yep, but in the meantime, let's clearly mark said firmware as
> not-covered-by-the-GPL. In the acenic case it seems to be even easier, as the
> firmware is in a separate acenic_firmware.h file, and it just needs to have
> the proper licencing statement added, saying that it is not covered by the
> GPL, and then giving the information under what licence it is being
> distributed.

Who has meaningfully contacted Alteon (probably "Neterion" now) about 
this?  What is the progress of that request?


> Jeff, since your name was found in the tg3.c case, and you seem to care about
> this too, what is your take on this proposal ?
> 
> Friendly,

Bluntly, Debian is being a pain in the ass ;-)

There will always be non-free firmware to deal with, for key hardware.

	Jeff


