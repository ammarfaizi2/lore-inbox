Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUJZSjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUJZSjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUJZSjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:39:16 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43491 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261391AbUJZSij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:38:39 -0400
Message-ID: <417E99A5.1060601@comcast.net>
Date: Tue, 26 Oct 2004 14:38:29 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
References: <7aaed09104102213032c0d7415@mail.gmail.com>	<7aaed09104102214521e90c27c@mail.gmail.com>	<417E74DD.6000203@comcast.net> <20041026110145.1a0052e4@zqx3.pdx.osdl.net>
In-Reply-To: <20041026110145.1a0052e4@zqx3.pdx.osdl.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Stephen Hemminger wrote:
| On Tue, 26 Oct 2004 12:01:33 -0400

[...]
|
|
| The Linux development model is not setup to be convenient for out of tree
| kernel development. This is intentional, if the project is out of tree no
| kernel developer is going to see it or fix it. Submit it and get it
reviewed
| and into the process or quit complaining and make and maintain your
| own "stable" tree.

"The Linux development model is intentionally crafted to impede progress."

That's all you had to say.

Progress has to occur outside mainline before it can be submitted.  By
impeding such progress, you potentially prevent things from keeping
current enough to reach a stable point and be ready for mainline
inclusion.  Overall, you're slowing down development and making it more
difficult.

[...]

|
| Everyone's list of what they want added to 2.6 is different. So the
| kernel work continues and is the union of everyone's good ideas (and
| a few bad ones).

Actually, a few minutes after this, I belted out a cheap and unrefined,
fairly hackish proposal[1] for a similar but slightly altered model.
Commentary on it and refinement may be nice.  Maybe I'm just trying to
make everybody happy, and it's not possible?

[1] http://lkml.org/lkml/2004/10/26/171

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfpmkhDd4aOud5P8RAmO4AJ4oxPajdqf6+xt3KUejxLRxZStASgCfded/
FmuWzyk865VsQr2uuIG/a1I=
=HYDL
-----END PGP SIGNATURE-----
