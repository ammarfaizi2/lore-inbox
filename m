Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUD2VLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUD2VLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUD2VIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:08:15 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:46094 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S264870AbUD2VBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:01:04 -0400
In-Reply-To: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--261440957"
Message-Id: <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>,
       Marc Boucher <marc@linuxant.com>,
       Timothy Miller <miller@techsource.com>
From: Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 23:00:57 +0200
To: Rik van Riel <riel@redhat.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-5--261440957
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 29, 2004, at 17:14, Rik van Riel wrote:

> On Thu, 29 Apr 2004, Timothy Miller wrote:
>
>>> "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
>>> cannot resolve problems you may encounter. Please contact
>>> $MODULE_VENDOR for support issues."
>>
>> Sounds very "politically correct", but certainly more descriptive and
>> less alarming.
>
> More importantly, it directs the support burden to where
> it, IMHO, belongs.

Just to throw in my two cents at the end of this long debate... :-)

I heartily endorse (for what little that is worth ;-) the change in 
text. It adds clarity, it provides more information as to where to go 
for information. It is hard to misconstrue as a message of impending 
doom, consider that a good synonym for tainted is corrupted, and a 
corrupted kernel is a bad thing :-).

Cheers,
Paul

--Apple-Mail-5--261440957
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAkW0Jtch0EvEFvxURAhRQAJ9X7ILuEPEzeZwjuAhsNUiFOr9vlgCfaJuP
pGomy6dMBUCs82eUeGoMWnM=
=b4Fw
-----END PGP SIGNATURE-----

--Apple-Mail-5--261440957--

