Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVCIKds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVCIKds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVCIKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:30:40 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:27563 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262283AbVCIK3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:29:30 -0500
Date: Wed, 9 Mar 2005 10:28:32 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Dominik Karall <dominik.karall@gmx.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.2
In-Reply-To: <200503091121.16801.dominik.karall@gmx.net>
Message-ID: <Pine.LNX.4.61.0503091023410.7496@student.dei.uc.pt>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
 <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
 <200503091121.16801.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 9 Mar 2005, Dominik Karall wrote:

>>>> which is a patch against the 2.6.11.1 release.  If consensus arrives
>>>> that this patch should be against the 2.6.11 tree, it will be done that
>>>> way in the future.
>>>
>>> IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
>>> againt
>>> the last -rc but against 2.6.x.
>>
>> It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most
>> logical to me.
>
> I don't think so. The latest patch (2.6.11.2 now) is on the frontpage of
> kernel.org, so IMHO the user should not need to search the kernel.org/pub
> archives to get 2.6.11.1 patch before he can start working with 2.6.11.2.
>
> I think it's a small problem too, that 2.6.11 source isn't directly accessable
> through the kernel.org frontpage while there is no "full tarball" of 2.6.11.X
> trees.

With that "full tarball" for 2.6.11.X the issues would be over.
I think there should be one.

Marado

- -- 
/* *********************************************************** */
    Marcos Daniel Marado Torres     AKA      Mind Booster Noori
    http://student.dei.uc.pt/~marado  -	 marado@magicbrain.biz
    () 	Join the ASCII ribbon campaign against HTML e-mail and
    /\ 	Microsoft attachments.        They endanger the World.
/* *********************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFCLs/gmNlq8m+oD34RAnu6AJwOvkvet1kLLGzLQ5EGuiVxtNbeEQCg7Ar9
Stnv4wmM74a5mX3fFrAh34Y=
=fCVH
-----END PGP SIGNATURE-----

