Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTLKPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTLKPH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:07:28 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:5554 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S265111AbTLKPH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:07:26 -0500
Date: Thu, 11 Dec 2003 13:05:36 -0400
From: Rhino <rhino9@terra.com.br>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-Id: <20031211130536.34e5202f.rhino9@terra.com.br>
In-Reply-To: <20031211114018.GB8039@holomorphy.com>
References: <3FD3FD52.7020001@cyberone.com.au>
	<20031208155904.GF19412@krispykreme>
	<3FD50456.3050003@cyberone.com.au>
	<20031209001412.GG19412@krispykreme>
	<3FD7F1B9.5080100@cyberone.com.au>
	<3FD81BA4.8070602@cyberone.com.au>
	<20031211060120.4769a0e8.rhino9@terra.com.br>
	<20031211114018.GB8039@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__11_Dec_2003_13_05_36_-0400_5AqBADmTAl_5ZZC0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__11_Dec_2003_13_05_36_-0400_5AqBADmTAl_5ZZC0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2003 03:40:18 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:


> It might help to check how many processes and/or threads are involved.
> I've got process scalability stuff in there (I'm not sure how to read
> your comments though they seem encouraging).
> 

heh, they were supposed to .it really looks good. 
if you provide me a test path to address your changes,
i'll happily put it on.

--Signature=_Thu__11_Dec_2003_13_05_36_-0400_5AqBADmTAl_5ZZC0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2KPgP7/1py/aJRgRAgHkAKC3I727SoHbTdvhtmiD/K7KqAiUZACeNMkp
YFzum3wrm5lIS7fujzHP3/8=
=5Cuq
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2003_13_05_36_-0400_5AqBADmTAl_5ZZC0--
