Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWFIQrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWFIQrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWFIQrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:47:05 -0400
Received: from [80.71.248.82] ([80.71.248.82]:35562 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030268AbWFIQrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:47:03 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Mike Snitzer <snitzer@gmail.com>, Alex Tomas <alex@clusterfs.com>,
       Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
	<4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>
	<44899113.3070509@garzik.org>
	<170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
	<4489A15E.5020904@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:48:58 +0400
In-Reply-To: <4489A15E.5020904@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 12:27:10 -0400")
Message-ID: <m3fyieb7gl.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> It's also a question of...  why keep adding modernizing features to
 JG> ext3, thus keeping it on life support, but just barely?  If we are
 JG> going to modernize the _main Linux filesystem_, let's not do it in a
 JG> way that is slow, and ties our hands.

I think trying to solve all problems at once will take much longer.

thanks, Alex

