Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319028AbSHMWG3>; Tue, 13 Aug 2002 18:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319042AbSHMWG3>; Tue, 13 Aug 2002 18:06:29 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:15299 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S319028AbSHMWG2>; Tue, 13 Aug 2002 18:06:28 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Linux 2.4.20-pre2 compile error
Date: Wed, 14 Aug 2002 08:05:02 +1000
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208131714360.19585-100000@sharra.ivimey.org>
In-Reply-To: <Pine.LNX.4.44.0208131714360.19585-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208140805.03039.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 14 Aug 2002 02:21, Ruth Ivimey-Cook wrote:
<snip>
> For example, recently I wanted to find the combined mouse device on an RH3
> system that I haven't got around to switching to devfs; after a lot of
> searching, including in the kernel sources, I gave up. On defvs it's
> obvious: you have /dev/mouse/, and under that "mice", which, being the
> plural of "mouse", is pretty clear, IMO.

Note that this is partly an experience (maybe even cultural) issue.

Given the same problem, I'd think "ah, mouse. Now that is an input device, so 
I'd expect it to be in /devin/input. Hmm - lots of mouse0, mouse1, etc type 
entries, and a "mice" entry. That'll probably be the one..."

I personally wouldn't think to look in /dev/mouse. And remember that we speak 
(mostly) the same language. Maus?

I guess it is just a matter of what you know.

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9WYKPW6pHgIdAuOMRAlGyAJ9Oh18IJwOG16GhwqO/5Jl/sMRwcwCdFR53
ecU1Ko3Y/s6TOBSuo7aXmGg=
=URqj
-----END PGP SIGNATURE-----

