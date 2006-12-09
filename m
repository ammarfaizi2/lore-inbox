Return-Path: <linux-kernel-owner+w=401wt.eu-S1947605AbWLIAn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947605AbWLIAn5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761318AbWLIAn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:43:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:45629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761317AbWLIAn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:43:56 -0500
Date: Fri, 8 Dec 2006 16:43:46 -0800
From: Seth Arnold <seth.arnold@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 0/2] file capabilities: two bugfixes
Message-ID: <20061209004346.GG21627@suse.de>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>
References: <20061208193657.GB18566@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <20061208193657.GB18566@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2006 at 01:36:57PM -0600, Serge E. Hallyn wrote:
> The other is that root can lose capabilities by executing files with
> only some capabilities set.  The next two patches change these
> behaviors.

I saw this in my code review and thought that this behaviour was
intentional. :) It seemed like a good idea to me..

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFFegbC+9nuM9mwoJkRAr9bAJ9Op5FBDLUQ57c8prmQ7roZ8lhyAwCfYdQO
JnXjy0Y3zs44LuP1kmRXZEU=
=q8zU
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
