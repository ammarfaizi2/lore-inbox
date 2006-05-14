Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWENSA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWENSA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWENSA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 14:00:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:31525 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751507AbWENSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 14:00:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=PiRLQD2MIEAx6r8xpsTutuf6GipgcVc7IQASwSZ5+/MSzEii8RlmpXfc7gYFjStIooMSEH/l9Afoy1H32mTMNbaTRd5ZnK940THifJ6Qo0tk1xHKF87G99Q6eywA22iyKu9xewGCzxz+bbIP2YIUMl+hV6653bWXdrvItOV/CWc=
Message-ID: <44677056.1080004@gmail.com>
Date: Sun, 14 May 2006 20:00:31 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: please git pull ACPI for 2.6.17
References: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brown, Len napsal(a):
>> is it possible to do so now, still before .17 release?
> 
> I think that on April 3rd this was appropriate.
> But now 6 weeks later in the release cycle I don't think it is
> appropriate to do such a large pull.
It seemed obvious, I just tried it, because there was a complain on bugzilla.
> 
> I'm assuming this tree will not be pulled until the start of .18.
Never mind.
> 
> Jiri,
> Is there a specific individual patch that you are wanting to have in
> .17?
I wanted to have ecdt-uid-hack there, because asus laptops' acpi is defunct, but
as I said, it doesn't matter, 2.6.18-rc1 is not so far.

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZ3BWMsxVwznUen4RAsk4AKDEhjpLcItL1v1MXe7ZShvTLUmONACgqpG9
uQPOD1X8gS9SX0C2avn8Hj8=
=l1s/
-----END PGP SIGNATURE-----
