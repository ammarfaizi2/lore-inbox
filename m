Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293604AbSCEElE>; Mon, 4 Mar 2002 23:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293605AbSCEEkz>; Mon, 4 Mar 2002 23:40:55 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:62592
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S293604AbSCEEko>; Mon, 4 Mar 2002 23:40:44 -0500
Date: Mon, 4 Mar 2002 20:40:26 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
In-Reply-To: <1015292630.882.78.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0203042037510.2947-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Robert,

In one message you wrote:

> Patch [...] is critical for all UP+preempt users.

and in another (in the same thread) you write:

> The above fix isn't needed for i386

I don't understand what to do in the UP i386 case - apply or not apply?

I suspect I'm misunderstanding what you mean by "the above fix".

Ben

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hEw+sYXoezDwaVARAmByAJ4iW2lVfJO61hRoAYmwige/7fyY3ACfS7Lk
ytnH2rCLgTvKgchWtt3cvVw=
=tb/c
-----END PGP SIGNATURE-----

