Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUELBhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUELBhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUELBhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:37:40 -0400
Received: from metawire.org ([24.73.230.118]:44850 "EHLO mail.metawire.org")
	by vger.kernel.org with ESMTP id S264155AbUELBhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:37:35 -0400
Date: Tue, 11 May 2004 20:37:41 -0500 (EST)
From: jnf <jnf@datakill.org>
X-X-Sender: jnf@metawire.org
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new laptop woes
In-Reply-To: <1084295342.12359.116.camel@dhcppc4>
Message-ID: <Pine.BSO.4.58.0405112032430.31433@metawire.org>
References: <A6974D8E5F98D511BB910002A50A6647615FB0B1@hdsmsx403.hd.intel.com>
 <1084295342.12359.116.camel@dhcppc4>
X-SUPPORT: 0xDEADFED5 lab pr0ud supp0rt3rz 0f pr0j3kt m4yh3m
X-GPG-FINGRPRINT: 7DB1 AEED B2C7 FE09 433C  5106 B0A0 1E4C 084B 8821
X-GPG-PUBLIC_KEY: http://www.bombtrack.org/~jnf/jnf.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


hi, yea nice to get a reply from you, I looked through all the listed 
kernel bugs relating to api, and I found several submitted by you- I guess 
i shouldve guessed you were the maintainer.

> try booting with "nolapic"

This worked - now seeing as it worked, and I can't find any mention of it 
in the bootparam man page [and i havent dug through the source yet], what 
exactly did i do?

> I escaped from CVS in 1994, underwent several years of therapy, and
> haven't used it since.  I don't know what ACPI CVS is on SF, point me to
> it and I'll be happy to delete it.

hehe no problem, I was under the impression that was the 'official' site 
for acpi, but i found that odd seeing as nothing on the site seemed newer 
than ~12 months, and i knew that ACPI had undergone some fixes/changes 
since then.

Anyways, thanks for the help. It's nice to have a bettery monitor now, 
although Im guessing my laptop doesnt support other extensions [i.e. 
current cpu temp in c is -------], but i suppose I can kind my answers 
about that stuff in the man pages/documentation. Anyways thanks for the 
help with the ACPI.

jnf


- -- 

It is only the great men who are truly obscene.  If they had not dared to 
be obscene, they could never have dared to be great.
                -- Havelock Ellis
 


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (OpenBSD)

iD8DBQFAoX/psKAeTAhLiCERAiV5AJ9oRJL0bzhZw7Xv8mDCLBL5OVLQrQCdELuW
7j/hsh2W1/YlBqN3gxOnsKE=
=Pe84
-----END PGP SIGNATURE-----
