Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUAFS0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUAFS0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:26:49 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:44701 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265061AbUAFS0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:26:41 -0500
Date: Tue, 6 Jan 2004 18:26:21 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: Linux mremap bug correction (fwd)
Message-ID: <Pine.LNX.4.58.0401061825330.7109@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Look what I've just recieved...

It seems that 2.2 isn't vulnerable after all.

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

- ---------- Forwarded message ----------
Date: Tue, 6 Jan 2004 17:30:35 +0100 (CET)
From: Paul Starzetz <ihaquer@isec.pl>
Reply-To: security@isec.pl
To: vulnwatch@vulnwatch.org, full-disclosure@lists.netsys.com,
     bugtraq@securityfocus.com
Subject: Linux mremap bug correction

Hi,

our initial posting contains a mistake about the vulnerability of the 2.2
kernel series. Since the 2.2 kernel series doesn't support the
MREMAP_FIXED flag it is NOT vulnerable. The source states
"MREMAP_FIXED option added 5-Dec-1999" but it didn't make into recent
2.2.x. We apologize for inconvenience.

- --
Paul Starzetz
iSEC Security Research
http://isec.pl/


- ------------ Output from gpg ------------
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/faq.html for more information
gpg: Signature made Tue 06 Jan 2004 04:30:40 PM WET using DSA key ID 9E70A6EE
gpg: Can't check signature: public key not found

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+v3SmNlq8m+oD34RAgF0AKDdqihpm5MWL2rxBvuwibehAoAEbACghemA
6wEeuJ/nEoWZpaSfUA0pDjU=
=VLWm
-----END PGP SIGNATURE-----

