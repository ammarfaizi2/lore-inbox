Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWFIQvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWFIQvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWFIQvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:51:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24464 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965297AbWFIQvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:51:17 -0400
Message-ID: <4489A6FB.9010402@garzik.org>
Date: Fri, 09 Jun 2006 12:51:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Mike Snitzer <snitzer@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>	<4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>	<44899113.3070509@garzik.org>	<170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>	<4489A15E.5020904@garzik.org> <m3fyieb7gl.fsf@bzzz.home.net>
In-Reply-To: <m3fyieb7gl.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> It's also a question of...  why keep adding modernizing features to
>  JG> ext3, thus keeping it on life support, but just barely?  If we are
>  JG> going to modernize the _main Linux filesystem_, let's not do it in a
>  JG> way that is slow, and ties our hands.
> 
> I think trying to solve all problems at once will take much longer.

I guess it's a good thing that real world development never works like that.

	Jeff



