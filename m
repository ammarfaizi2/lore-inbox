Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268860AbUICOam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268860AbUICOam (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUICOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:30:42 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:1449 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S268860AbUICOaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:30:25 -0400
Date: Fri, 3 Sep 2004 15:29:09 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Valdis.Kletnieks@vt.edu
cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>,
       Oliver Hunt <oliverhunt@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
In-Reply-To: <200409022133.i82LXc38022679@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0409031528420.19868@student.dei.uc.pt>
References: <1094008341.4704.32.camel@wizej.agilysys.com>
 <200408312358.08153.dsteven3@maine.rr.com> <1094041227.4635.7.camel@wizej.agilysys.com>
 <200409011135.36537.dsteven3@maine.rr.com> <1094055985.4635.44.camel@wizej.agilysys.com>
 <4699bb7b04090109415f64fea1@mail.gmail.com>           
 <1094067612.15795.19.camel@wizej.agilysys.com> <200409022133.i82LXc38022679@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 2 Sep 2004 Valdis.Kletnieks@vt.edu wrote:

> A somewhat subtle gotcha that I got bit by once - very bad things
> happen if you try to load reiserfs off an ext2-formatted initrd image,
> and your kernel doesn't have ext2 built in.  (Feel free to substitute
> any 2 filesystem formats - I actually got nailed by ext2/ext3)...

Well, in my case that's not the problem...

Marcos Marado

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

iD8DBQFBOH+3mNlq8m+oD34RAkhUAKC4+wdzMHzHqoRCecFGOXvAzF9NqwCg8DSh
EcL7JMsoNNgL3D534efCWsA=
=3soR
-----END PGP SIGNATURE-----

