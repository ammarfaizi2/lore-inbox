Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUBLRUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUBLRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:18:47 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:23276 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S266530AbUBLRRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:17:07 -0500
Date: Thu, 12 Feb 2004 17:16:51 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Nick Bartos <spam99@2thebatcave.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions not done updating when init is ran?
In-Reply-To: <50391.192.168.1.12.1076590842.squirrel@mail.2thebatcave.com>
Message-ID: <Pine.LNX.4.58.0402121715310.27694@student.dei.uc.pt>
References: <46246.192.168.1.12.1076553774.squirrel@mail.2thebatcave.com>  
    <Pine.LNX.4.58.0402120457250.28596@student.dei.uc.pt>   
 <50365.192.168.1.12.1076590069.squirrel@mail.2thebatcave.com>
 <50391.192.168.1.12.1076590842.squirrel@mail.2thebatcave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 12 Feb 2004, Nick Bartos wrote:

> OK yes I see that CONFIG_BLK_DEV_NBD is disabled.  Any other ideas?

Well, does it still happen with 2.4.25-rc2 ?

> > No, it is 2.4.25-pre7.  I could technically go to 2.6.x, but it would take
> > a bit of work due to some other changes.  I would really like to get this
> > stable in 2.4.x.

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

iD8DBQFAK7UGmNlq8m+oD34RAv5wAJwPjsIOMB55zSF//9MnnQDEIYRDpwCeMfJ5
Au44XTzEf+tbjosvG9Dvo3U=
=h41f
-----END PGP SIGNATURE-----

