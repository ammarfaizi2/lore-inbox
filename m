Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbULOExH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbULOExH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbULOEwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:52:46 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:41377 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S261882AbULOEwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:52:15 -0500
Message-ID: <41BFC2FC.80905@slaphack.com>
Date: Tue, 14 Dec 2004 22:52:12 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040924)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200412141930.iBEJUGdB019336@laptop11.inf.utfsm.cl>
In-Reply-To: <200412141930.iBEJUGdB019336@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
| Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
|
| [...]
|
|
|>Perhaps a better way to think about this is that instead of talking
|>about directories and files, we just talk about objects.
|
|
| Then you have a collection of interrelated objects, i.e., a database.
| Operating systems that work on databases (no filesystem) have been done,
| and are a nice idea... but are far, far away from Unix.

Really? Because most Unix tools don't behave all that strangely when I
enable metadata. If Linux incrementally changes into something that is
not Unix, what is lost, besides the name?

Remember that a filesystem is a specialized database. It is specialized
for performance. If Hans can generalize it without losing that
performance, who can complain?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQb/C+3gHNmZLgCUhAQIjGg/+M17+XviIqi+uFy3RR6x8csoPne3KYBlL
cnjoDML4JZAXLn0YdDKAafCa1kt4xCbPYa/ZQjqw9RzUbnf6YEtdrvuVsLxsTC7t
yAHQDSFCpQ1ssCsy5S2ku80Srx6LkTf2R33F8BMr0hTVNg5eoDEL2RuOtT8tJ0g5
gMrdX04BIM4gxQEv2elvfNIm7cxyAv1aBvurcpb/VPckoaUChPQSgauuS6rJ0oYu
AmLhkLBZ+8NloQ2U4tKHdY8YrQWtLAzeyG+rYwIFxjPWRMUG54WYAVD+G2R6a9bN
nksqOtZ19lcCdjBOb5+5Wa3sOEOgwYRKySS4H/S/TTBI8cbm5+7tDwi30E4eiV9C
PQUi+yi3+18j+cp3Of+AhZsA99PgjJ9q7GKaC10SX5/gk0d2jq0TwADBR1v2EdbM
cABfKnaXWnS0RzqFARF/MZaZz++KWAbmsZwnTk7N9Tm2AfKSRjFb5wqsKbV01F+i
XltsPGnYj0f4DYKrSxQRxkhQxC5J9b2P69N9JhplvzcvAVQWIMvhPsU10i4vm7oN
GJi+ncuYzmdQQXB0Sxpar5uwdYj+xgcWcK35iX4mGG9E6CWythpKJQFq85u/KKsX
J37o0CcxY1eseV+5qgYEeGm0eLuoxllaKNW9yJzsX9Xf2qxUoS1mr0si2eFulsLh
z72g9LoNfyg=
=hIBh
-----END PGP SIGNATURE-----
