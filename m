Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbULCSsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbULCSsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULCSsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:48:12 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:38840 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261889AbULCSsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:48:06 -0500
Date: Fri, 3 Dec 2004 18:46:41 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Len Brown <len.brown@intel.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] ACPI for 2.6.10
In-Reply-To: <1101945436.8026.392.camel@d845pe>
Message-ID: <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
References: <1101945436.8026.392.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 1 Dec 2004, Len Brown wrote:

> Hi Linus, please do a
>
> 	bk pull bk://linux-acpi.bkbits.net/26-latest-release

If this release is equivalent with -mm's bk-acpi.patch from 2.6.10-rc2-mm1 to
2.6.10-rc2-mm4, notice that this kernels' bk-acpi patches have the bug
described in http://lkml.org/lkml/2004/11/16/263 , so I wouldn't really like to
see this pull done to 2.6.10 until the problem is solved...

If you want, I can try this patch to see if it acts like bk-acpi.patch, but I
guess it does...

Best Regards,
Marcos Marado

> thanks,
> -Len
>
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20041105-26-latest-release.diff.gz

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

iD8DBQFBsLSTmNlq8m+oD34RAsmNAJ9CZ8nYf5vAUCWgcw+8goIfCPzgMwCeJbX7
K6IwrmiNyhm3a4bYbSrXNv8=
=RMUe
-----END PGP SIGNATURE-----

