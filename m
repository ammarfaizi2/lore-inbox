Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266647AbRGOP7H>; Sun, 15 Jul 2001 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266653AbRGOP65>; Sun, 15 Jul 2001 11:58:57 -0400
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:40926 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S266647AbRGOP6n>; Sun, 15 Jul 2001 11:58:43 -0400
Date: Sun, 15 Jul 2001 12:00:14 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
cc: lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <3B50DBAE.7030406@lycosmail.com>
Message-ID: <Pine.LNX.4.20.0107151158360.645-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Adam Schrotenboer wrote:

> Sorry if this is a repost.
> 
> I am upgrading to a new 36GB HD, and intend to split it into 3 pieces: 
> one 7GB vfat, one ~28GB linux data (reiser or ext2), and 1GB swap.
> 
> I need to know if I can trust ReiserFS, as I do believe that I do want 
> ReiserFS.

Which is a good point - can ext2 handle more than 4gig partitions ? I have
some vague ideas that it doesn't (and that it does not handle files more
than 2gig long). I am reasonable sure that ReiserFS is better in this
regard though I am not certain about this either.

                               Vladimir Dergachev

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


