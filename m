Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVCDTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVCDTsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVCDTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:48:19 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:920 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263027AbVCDT3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:29:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=dI06Em6Yqtxm6qy1y9xmfBvQnjS+8EXHhRsKTwtBw17ManGRYfFxn/VKDXHq9JGeqaiE3RWu5Y35p92R16jIdxwIq97COQA+SUQ04cxRJjk+ytz9W1P7mDAMXKfiDccEIV5TXLxLhZaof9E7BcmNrKGqstO6lLojbtj8biHfJWc=
Message-ID: <4228B6FA.6040606@gmail.com>
Date: Fri, 04 Mar 2005 20:28:58 +0100
From: Paolo <paoloc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com
CC: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.1
X-Enigmail-Version: 0.90.1.1
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| For those of you who haven't waded through the huge "RFD: Kernel release
| numbering" thread on lkml to realize that we are now going to start
| putting out 2.6.x.y releases, here's the summary:
|
| 	A few of us $suckers will be trying to maintain a 2.6.x.y set of
| 	releases that happen after 2.6.x is released.  It will contain
| 	only a set of bugfixes and security fixes that meet a strict set
| 	of guidelines, as defined by Linus at:
| 		http://article.gmane.org/gmane.linux.kernel/283396
|
| Chris Wright and I are going to start working on doing this work, we
| will have a <SOME_ALIAS>@kernel.org to post these types of bug fixes to,
| and a set of people we bounce the patches off of to test for "smells
| good" validation.  We will also have a bk-commits type mailing list for
| those who want to watch the patches flow in, and a bk tree from which
| changsets can be pulled from.
|
| Chris and I will be hashing all of the details out next Tuesday, and
| hopefully all the infrastructure will be in place soon.  When that
| happens, we will post the full details on how all of this is going to
| work.  In the meantime, feel free to CC: me and Chris on patches that
| everyone thinks should go into the 2.6.11.y releases.
|
| But right now, Chris is on a plane, and we don't have the email alias
| set up, or the proper permissions set up on kernel.org to push changes
| into the v2.6 directory, but we have a few bugs that are needing to be
| fixed in the 2.6.11 release.  And since our mantra is, "release early
| and often", here's the first release.

First of all, congratulation.
I really think this will be a great improvement to the development process.

I couldn't agree more with this decision, it's really what I suggested a
few months ago:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109882220123966&w=2

Out of curiosity, are you going to include the -as branch ?

		Paolo


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCKLb6xcZDms2c3jQRAkmBAJ9fNXkoo+ATm2wezsRyQzrRxh6siACdFzVo
0cllOTLr40ALnK2S3VJENa0=
=jWOp
-----END PGP SIGNATURE-----
