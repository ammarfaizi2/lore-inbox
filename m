Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVL1HXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVL1HXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVL1HXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:23:09 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:41137 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932335AbVL1HXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:23:07 -0500
Message-ID: <43B23D53.6030206@stesmi.com>
Date: Wed, 28 Dec 2005 08:22:59 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: michael@metaparadigm.com, pwil3058@bigpond.net.au, rlrevell@joe-job.com,
       s0348365@sms.ed.ac.uk, rostedt@goodmis.org, jaco@kroon.co.za,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
References: <43AF7724.8090302@kroon.co.za>	<200512261535.09307.s0348365@sms.ed.ac.uk>	<1135619641.8293.50.camel@mindpipe>	<200512262003.38552.s0348365@sms.ed.ac.uk>	<1135630831.8293.89.camel@mindpipe>	<43B1D6C6.30300@metaparadigm.com>	<43B1E5C1.4050908@bigpond.net.au>	<43B1F203.6010401@metaparadigm.com>	<20051227181239.3338b848.rdunlap@xenotime.net>	<43B204F1.1010409@bigpond.net.au>	<43B20657.30508@metaparadigm.com>	<20051227193309.756f654a.rdunlap@xenotime.net> <20051227193956.6fb9e957.rdunlap@xenotime.net>
In-Reply-To: <20051227193956.6fb9e957.rdunlap@xenotime.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

>>>>>so where is this 'Preformat' option?  I don't see it.
>>>>
>>>>
>>>>Nor me.
>>>>
>>>
>>>It is a drop down box in the Compose window just below the subject field
>>>on the left (intially says "Body Text").
>>
>>However, if one has disabled "Compose messages in HTML format",
>>that drop-down list does not show up.
>>So does this generate an HTML email, using <preformat> or <tt> etc.?
>>If so, still bad.  I'll test it to myself.
> 
> 
> Looks good.  Preserves tabs and spaces.  Not HTML email.
> Thanks.

It's not perfect but ok. I'm running the FC4 version of Tbird 1.0.7 and
it works as it should with tabs and spaces everywhere if I don't sign
or encrypt the mail.

If I DO sign or encrypt the mail (using Enigmail+gpg) then the preformat
is effectively turned off and all tabs are converted to spaces, but
spaces are left as is.

How does the other mail clients handle it (or don't they handle signed
and/or encrypted mails?).

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDsj1TBrn2kJu9P78RAk/rAJ0br09iGrmMa1EdcqThUmZbfbfH+gCfUEEe
ihJpvwzdADr9bHSlopY6ipw=
=Smdd
-----END PGP SIGNATURE-----
