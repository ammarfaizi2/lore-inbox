Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263223AbVCDXnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbVCDXnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVCDXlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:41:32 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:40860 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263257AbVCDVtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:49:14 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Date: Fri, 4 Mar 2005 13:48:22 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <4228B514.4020704@keyaccess.nl>
Message-ID: <Pine.LNX.4.62.0503041342560.30782@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
 <4228B514.4020704@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Rene Herman wrote:

> Linus Torvalds wrote:
>
>> I've long since decided that there's no point to making "-pre". What's the 
>> difference between a "-pre" and a daily -bk snapshot? Really?
>
> The fact that not a script, but Linus Torvalds, decides that the tree is in a 
> state he likes to share with others. You have been doing -pre's all this 
> time, it's just that you are calling them -rc's.

remember that there are the nightly CVS dumps and patches being created as 
well.

from my point of view it appears that when Linus releases -rc1 he is 
hopeing that it's actually going to be final, but since nobody bothers to 
test before that it has never actually been the case. As a result 
additional changes need to be done and Linus chooses to fix it by moving 
forward and doing additional fixes rather then by reverting patches. He 
does allow some additional patches to move in as well for a little while, 
but all of them are expected to be fixes.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
