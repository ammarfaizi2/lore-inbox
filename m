Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281427AbRKPO0R>; Fri, 16 Nov 2001 09:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281428AbRKPO0I>; Fri, 16 Nov 2001 09:26:08 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:46853 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S281427AbRKPOZx>; Fri, 16 Nov 2001 09:25:53 -0500
Date: Fri, 16 Nov 2001 07:25:44 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: 2.2.14 hangs on Dell PowerEdge 6300
In-Reply-To: <3BF4C19A.10E7844F@otpbank.hu>
To: Nagy Tibor <nagyt@otpbank.hu>
Cc: linux-kernel@vger.kernel.org, jesper@home.linuxpusher.dk, jalvo@mbay.net
Message-id: <Pine.LNX.4.33.0111160718370.12990-100000@jbourne2.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
X-Comment: This communication is intended for the use of the recipient to which
 it is
X-Comment: addressed, and may contain confidential, personal, and or privileged
X-Comment: information.  Please contact the sender immediately if you are not
 the
X-Comment: intended recipient of this communication, and do not copy,
 distribute, or
X-Comment: take action relying on it.  Any communication received in error, or
X-Comment: subsequent reply, should be deleted or destroyed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Nagy Tibor wrote:

> I am sorry, this the same message as yesterday, but I misstyped the
> version. It is about 2.4..., of cource.
>
> Hi,
>
> we were satisfied with linux kernel version 2.4.9. Our linux server is
> unusable with kernel version 2.4.10 and higher, also with 2.4.14
> declared to be stable.
>
> We are working on Dell PowerEdge 6300 (4 Pentium Xeon/550Mhz, 4GB RAM).
> Any kernel from 2.4.10 to 2.4.14 brings our machine to a hanging state.
> Nothing can be determined, I guess, something is wrong with memory
> management. Unfortunately there is no more information about the
> problem.

I think you will need more information to get any type of sane reply.

We are running 2.4.14 on a PE6400, quad 700/4G in a production environment.
It has been stable, VM works well, using ext2 due to problems with the ext3
patch for that particular version of kernel.

eepro100 NICs, MegaRAID driver running raid1 and raid5, aic7xxx...

If you want to contact me off line, we can compare kernel configs etc.

Regards
James Bourne

>
> ------------------------------------------------------------------------
> Tibor Nagy
> National Savings and Commercial Bank Ltd (OTP Bank)
> H-1051 Budapest Nador u. 16.
> Tel: 00 36 1 374 6990	Fax: 00 36 1 374 6981	E-mail: nagyt@otpbank.hu
> ------------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

