Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbRBSPiO>; Mon, 19 Feb 2001 10:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRBSPiG>; Mon, 19 Feb 2001 10:38:06 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:58386 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129554AbRBSPhw>; Mon, 19 Feb 2001 10:37:52 -0500
Date: Mon, 19 Feb 2001 10:37:32 -0500
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@redhat.com>, dek_ml@konerding.com
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
Message-ID: <1448560000.982597052@tiny>
In-Reply-To: <E14UfYV-00029I-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, February 19, 2001 01:55:57 AM +0000 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> it had been cleared up.  In particular, the Configure.help in 2.4.2-pre4
>> says "reiserfs can be used for anything that ext2 can be used for".
> 
> The configure.help is wrong on that and one other thing. NFS doesnt work
> without extra patches and big endian boxes dont work with reiserfs
> currently
> 
> Chris - would it be worth sending me a patch that notes the NFS thing in
> Configure.help and includes the patch url ?

Yes, it would.  I'd rather put a link to www.reiserfs.org, where the
quota/NFS/big endian patches will be linked to.  Sound good?

-chris

