Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSAHTXV>; Tue, 8 Jan 2002 14:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288257AbSAHTXM>; Tue, 8 Jan 2002 14:23:12 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:40605 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S288255AbSAHTW7>; Tue, 8 Jan 2002 14:22:59 -0500
Date: Tue, 8 Jan 2002 11:23:30 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Sourav <jeebu19@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DLink DFE 538 TX (TealTek 8139) too slow
In-Reply-To: <005c01c19876$30b51060$03015b0a@bulee>
Message-ID: <Pine.LNX.4.33.0201081121510.8234-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can only negotiate half duplex on a hub... since you only have two 
computers connecting them with a reversal cable with allow you configure 
them both for 100Mb/s full-duplex.

joelja

On Wed, 9 Jan 2002, Sourav wrote:

> Why is DLink DFE 538TX Realtek 8139 too slow over
> 10Mbps HUB ( ~1Mbps) and apparantly too many
> collisions on a 2 computer network??!!! It also
> shows Half Duplex autonegotiated!!
> 
> Regards,
> Sourav
> 
> 
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
The accumulation of all powers, legislative, executive, and judiciary, in 
the same hands, whether of one, a few, or many, and whether hereditary, 
selfappointed, or elective, may justly be pronounced the very definition of
tyranny. - James Madison, Federalist Papers 47 -  Feb 1, 1788


