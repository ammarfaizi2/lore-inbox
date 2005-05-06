Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVEFOoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVEFOoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVEFOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:44:24 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:24967 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261248AbVEFOoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:44:19 -0400
Date: Fri, 6 May 2005 17:44:02 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: chas3@users.sourceforge.net
cc: Willy Tarreau <willy@w.ods.org>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and
 openafs 1.3.82 
In-Reply-To: <200505061423.j46ENfTG024192@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.62.0505061743080.20098@tassadar.physics.auth.gr>
References: <200505061423.j46ENfTG024192@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.158; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr>,Dimitris
> Zilaskos writes:
>> May  6 04:55:29 system kernel: kernel BUG at inode.c:1204!
>
> looks like you might have one of those kernels with extra bits (in
> particular, i_notify).  please try a later version of afs like 1.3.81.
>

Hello ,

This particular error occured with kernel 2.4.30 and openafs 1.3.82.

Best regards ,


--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================
