Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJIKvg>; Wed, 9 Oct 2002 06:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJIKvg>; Wed, 9 Oct 2002 06:51:36 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63471 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261522AbSJIKvf>; Wed, 9 Oct 2002 06:51:35 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0210080850270.3110-100000@dlang.diginsite.com> 
References: <Pine.LNX.4.44.0210080850270.3110-100000@dlang.diginsite.com> 
To: David Lang <david.lang@digitalinsight.com>
Cc: simon@baydel.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 11:53:29 +0100
Message-ID: <15392.1034160809@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


david.lang@digitalinsight.com said:
> note that you are allowed to distribute a binary-only module as long
> as you don't use the GPL-only kernel symbols. 

Is this formal legal advice?

> Linus has stated that he doesn't view use of the header files as enough
> to make a module a dirivitive work

Linus explicitly refused to collect copyright assignments from contributors.
Therefore he doesn't have the authority to make that kind of variation in
the licence. And variation it is, in the opinion of many people who own 
copyright on parts of the Linux kernel.

> (others disagree, but there are a number of binary modules out there) 

Indeed others do disagree. And the fact that existing vendors of 
binary-only modules haven't _yet_ been sued for it is not a guarantee that 
it will not happen. Unlike trademarks, copyright does not become void if 
you fail to protect it for a while.

Anyone releasing binary only modules does run a non-zero risk of being sued
for it. Opinion varies on the likelihood of them actually losing the case if
that happens.

Anyone considering releasing a non-GPL kernel module should consult their
own lawyers at their own expense, and make their own decision as to whether
the risk is acceptable.

--
dwmw2


