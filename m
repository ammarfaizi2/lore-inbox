Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSKAXKj>; Fri, 1 Nov 2002 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265826AbSKAXKi>; Fri, 1 Nov 2002 18:10:38 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:19136 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265816AbSKAXKb>; Fri, 1 Nov 2002 18:10:31 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Wes Felter <wesley@felter.org>, Miles Lane <miles.lane@attbi.com>
Subject: Re: Will we have UPnP support for Linux?
Date: Sat, 2 Nov 2002 10:07:55 +1100
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <3DC1DD1E.6000701@attbi.com> <1036177217.26996.9.camel@arlx002.austin.ibm.com>
In-Reply-To: <1036177217.26996.9.camel@arlx002.austin.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211021007.56086.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 2 Nov 2002 06:00, Wes Felter wrote:
> On Thu, 2002-10-31 at 19:47, Miles Lane wrote:
>
> [UPnP URLs snipped]
>
> Is this a kernel feature? AFAIK UPnP is just another application
> protocol on top of UDP, so it can be done in userspace. And didn't Intel
> release a UPnP stack on SourceForge? Whoa, I see 7 UPnP projects on SF;
> at least one of them is probably real.
Probably you want to go with the IETF approach - Service Location Protocol 
(RFC2608, RFC2609, RFC2610, RFC2614 and some others). There is a reasonable 
open source implementation (OpenSLP), and no dodgy vendor association.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9wwlMW6pHgIdAuOMRAvLKAJ9iUw3q7ISYSok2ULwnH+UJeHNCJgCfV37h
0X20BM031CdfL696wzioMfA=
=coAW
-----END PGP SIGNATURE-----

