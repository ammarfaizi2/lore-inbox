Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVCIKSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVCIKSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVCIKSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:18:00 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:29862 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262242AbVCIKRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:17:35 -0500
Date: Wed, 9 Mar 2005 10:17:13 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.2
In-Reply-To: <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61.0503091014580.7496@student.dei.uc.pt>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
 <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 9 Mar 2005, Geert Uytterhoeven wrote:

>>> which is a patch against the 2.6.11.1 release.  If consensus arrives
>>> that this patch should be against the 2.6.11 tree, it will be done that
>>> way in the future.
>>
>> IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
>> againt
>> the last -rc but against 2.6.x.
>
> It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most logical to
> me.

Well, yes, _if_ 2.6.12 patch is going to be to aply against 2.6.11.last instead
of 2.6.11. And, well, either one will cause great panic for hose who aren't and
the mailing lists and just visit kernel.org to downoad the latest stuff.

Marado

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFCLs0rmNlq8m+oD34RAk+0AJsFwRyZ7vF9cE9thGYs/QjiVIjwjgCfclMR
nopc5sBPVauXqQCUeMxjYlM=
=YlzR
-----END PGP SIGNATURE-----

