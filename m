Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273435AbRINRRz>; Fri, 14 Sep 2001 13:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273436AbRINRRp>; Fri, 14 Sep 2001 13:17:45 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:15633 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S273435AbRINRRa>; Fri, 14 Sep 2001 13:17:30 -0400
Date: Fri, 14 Sep 2001 18:17:52 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4, 2.4-ac and quotas
In-Reply-To: <E15hwLr-0000Zl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109141815020.30680-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:02 +0100 Alan Cox wrote:

>> We've recently upgraded our two Debian potato fileservers to 2.4 and
>> 2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
>> and quotas have stopped working.
>
>The -ac kernels use the updated quota tools - they are needed to support
>32bit uid quota

OK.. so I download and build quota-3.01-pre9 on my woody box and I still
get EINVAL (2.4.9-ac10 + ext3 0.9.9 + ext3 speedup + ext3 experimental VM
patch + jfs 1.0.4). Can you tell me where the updated tools are please?

