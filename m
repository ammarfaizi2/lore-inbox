Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUAUJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUAUJO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 04:14:26 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:6105 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262228AbUAUJOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 04:14:24 -0500
Date: Wed, 21 Jan 2004 09:14:04 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5
In-Reply-To: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0401210911060.26264@student.dei.uc.pt>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 20 Jan 2004, Thomas Molina wrote:

> I am getting the following error messages:

[...]

> as well as:
>
> Error for wireless request "Set Mode" (8B06) :
>     SET failed on device eth0 ; Invalid argument.
> Error for wireless request "Set Frequency" (8B04) :
>     SET failed on device eth0 ; Operation not supported.
>
> This is the result of loading the drivers and activating eth0 for my
> wireless ethernet card.  It is an SMC card using orinoco, orinoco_cs, and
> hermes drivers.

Well, I experienced this myself last night when trying ndiswrapper 0.4 as the
way to use my Intel Centrino Wireless Card, before seeing this massage I was
thinking it was ndiswrapper's fault...

(Happened to 2.6.1-mm4 and 2.6.1-mm5)

> I've included two files.  The first is the output of lspci and the second
> is the configuration used to build 2.6.1-mm5.

If needed ask me and I'll do the same.

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFADkLemNlq8m+oD34RAuX0AKCltPFqNuPcJ3//kTZGOQ53oyhjAQCg3kgf
+CKYsDsO/q3XmJLQodONbEA=
=+0Hm
-----END PGP SIGNATURE-----

