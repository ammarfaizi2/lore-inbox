Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267187AbUFZQgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267187AbUFZQgM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUFZQgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:36:12 -0400
Received: from mout0.freenet.de ([194.97.50.131]:61321 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S267187AbUFZQet convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:34:49 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: kernel@kolivas.org
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Sat, 26 Jun 2004 18:33:29 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <200406252148.37606.mbuesch@freenet.de> <1088212304.40dccd5035660@vds.kolivas.org>
In-Reply-To: <1088212304.40dccd5035660@vds.kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406261833.52060.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 26 June 2004 03:11, you wrote:
> There was the one clear bug that Adrian Drzewiecki found (thanks!) that is easy
> to fix. Can you see if this has any effect before I go searching elsewhere?

Ok, I'll try it.


OT:
Some mails bounce on kernel@kolivas.org:

This is the Postfix program at host bhhdoa.org.au.

####################################################################
# THIS IS A WARNING ONLY.  YOU DO NOT NEED TO RESEND YOUR MESSAGE. #
####################################################################

Your message could not be delivered for 4.0 hours.
It will be retried until it is 5.0 days old.

For further assistance, please send mail to <postmaster>

                        The Postfix program

<kernel@kolivas.org>: connect to kolivas.org[211.28.147.198]: Connection timed
    out


Final-Recipient: rfc822; kernel@kolivas.org
Action: delayed
Status: 4.0.0
Diagnostic-Code: X-Postfix; connect to kolivas.org[211.28.147.198]: Connection
    timed out
Will-Retry-Until: Wed, 30 Jun 2004 13:29:45 -0400 (EDT)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3aVtFGK1OIvVOP4RApVwAJ9ows81hLZoQtiFer5/F9DDZwKrHACdF/Cs
y1sfWD8BusvvLWJMJbcT+yY=
=Kd+H
-----END PGP SIGNATURE-----
