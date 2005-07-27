Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVG0VKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVG0VKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVG0VIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:08:25 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47049 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262160AbVG0VGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:06:36 -0400
Message-Id: <200507272106.j6RL6HQB007305@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Variable ticks 
In-Reply-To: Your message of "Wed, 27 Jul 2005 16:43:07 EDT."
             <1122496987.22844.3.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com> <1122326750.1472.46.camel@mindpipe> <Pine.LNX.4.61.0507270212080.7784@montezuma.fsmlabs.com>
            <1122496987.22844.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122498377_4810P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Jul 2005 17:06:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1122498377_4810P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Jul 2005 16:43:07 EDT, Lee Revell said:

> As far as legacy support, AFAIK esd and artsd both grab the sound device
> on startup and never release it.

'man esd' on a FC4 system includes:

         -as SECS     free audio device after SECS of inactivity

and has '-as 2' specified in /etc/esd.conf.

--==_Exmh_1122498377_4810P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5/dJcC3lWbTT17ARAsm6AJ4zF2UZcqalNKXhklCgWR32pfZBegCgkuSS
pEDSzacymGWNJWtoE1+Mnzo=
=XjvN
-----END PGP SIGNATURE-----

--==_Exmh_1122498377_4810P--
