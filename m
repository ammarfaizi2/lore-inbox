Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbUHZJOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbUHZJOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUHZJOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:14:12 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10656 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268067AbUHZJC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:02:28 -0400
Message-ID: <412DA725.4040200@namesys.com>
Date: Thu, 26 Aug 2004 02:02:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com> <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk> <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk> <412CDA68.7050702@namesys.com> <20040825184523.GA15419@lst.de>
In-Reply-To: <20040825184523.GA15419@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>
>
>I don't think you'll get anywhere with auditing.  We need to write down
>the semantics you want, define them at the VFS level and make sure
>they're not conflicting with defined userspace semantics or kernel
>assumptions.
>
>I think you need to learn the basic distinction between the VFS layer
>and a lowlevel filesystem driver.
>
>
>
>  
>
How old are you?  I thought you were the guy at Linux Tag with fashion 
oriented hair who gave a talk on his XFS work?  Did I confuse you with 
someone else?


Hans
