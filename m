Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWCVQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWCVQOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWCVQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:14:15 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:674 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750704AbWCVQOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:14:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=Jx0VowcGuC3Ut620izZiv9tGfrJe0LWaKyCQYdT14x3MTtoHXB4+7EFnwo+2UMis8FEfj31DcXOuv8Vx0hBq6nEGB/oYFTqR1Q0nm9jjxfhqwpvZgPd7N4GmCKmALZJtRXCjDCsz/drq3KHA6cTyBFX1R5q7zdE0AhKogUcozKo=
Message-ID: <442178BA.9080302@gmail.com>
Date: Wed, 22 Mar 2006 23:18:02 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-user@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jdike@addtoit.com,
       stefano.melchior@openlabs.it
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX> <44215B8F.6060400@gmail.com> <200603221640.50362.blaisorblade@yahoo.it>
In-Reply-To: <200603221640.50362.blaisorblade@yahoo.it>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
> For SKAS mode use the normal debug sequence:
> 
> $ gdb vmlinux
> (gdb) <set breakpoints, do what you want>
> (gdb) run <params>
> 
> More info at the "debugging UML" link, "SKAS" subsection on the main site.

Thank you Blaisorblade,

Oh sorry, I didn't keep my eyes open. It's easy to miss the "Kernel
debugging in skas mode" (
http://user-mode-linux.sourceforge.net/debugging-skas.html ) link on
"Kernel debugging" (
http://user-mode-linux.sourceforge.net/debugging.html ) section.

I wonder why "kernel debugging (under TT mode)" is accessed directly on
UML homepage when TT mode is "old".

Thank you all.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIXi6NWc9T2Wr2JcRAlIeAKCLvElfMxfWgSDMRJSSO7Xv7M5ndwCfY4qk
MwW+qvmOQMOAQGgWyoPB7g8=
=yJ4o
-----END PGP SIGNATURE-----
