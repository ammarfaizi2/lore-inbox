Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRLDCPL>; Mon, 3 Dec 2001 21:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279998AbRLDANI>; Mon, 3 Dec 2001 19:13:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17936 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284944AbRLCSqE> convert rfc822-to-8bit; Mon, 3 Dec 2001 13:46:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fwd: Re: OT: svscan and the hard disk
Date: 3 Dec 2001 10:45:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ugh8b$oh4$1@cesium.transmeta.com>
In-Reply-To: <20011130123323.CED6DFA61@bugs.unl.edu.ar> <20011201002956.A3050@dardhal.mired.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id fB3IjWi03462
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011201002956.A3050@dardhal.mired.net>
By author:    =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
In newsgroup: linux.dev.kernel
>
> On Friday, 30 November 2001, at 09:33:21 -0300,
> Martín Marqués wrote:
> 
> > Any thoughts on what DJB thinks of the Linux FS?
> > 
> > Sorry for him, each day I convince myself of not using Qmail ever!
> > 
> Does this means that the opinions of those who don't think like you
> doesn't quality, or worth being taken into account ?.
> 
> How many times a week do you hear "subsystem X is broken", or "kernel
> developer Y fucked this" on this list ?. Is this different from the same
> facts, but being said by someone (DJB) who obviously has many people
> against, for several reasons (many of them, non-technical ones) ?
> 
> PS: first and last email from my part on this subject.
> 

The thing about it, is that he seems to be complaining about *HIS OWN*
bugs!  If he relies on system calls having semantics any other than
the one specified in the POSIX standard, his code is either
fundamentally broken, or he needs it very clearly documented.  He
seems to be relying on "well, BSD behaved this way in the past" and
then blames Linux when his assumptions fall apart.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
