Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUJSVa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUJSVa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJSV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:28:48 -0400
Received: from smtp.ono.com ([62.42.230.12]:23858 "EHLO mta02.onolab.com")
	by vger.kernel.org with ESMTP id S269690AbUJSV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:28:14 -0400
Message-ID: <41758690.7090500@hispalinux.es>
Date: Tue, 19 Oct 2004 23:26:40 +0200
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com>
In-Reply-To: <417550FB.8020404@drdos.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff V. Merkey wrote:

| On a side note, the GPL buyout previously offered has been modified. We
| will be contacting
| individual contributors and negotiating with each copyright holder for
| the code we wish to
| convert on a case by case basis. The remaining portions of code will
| remain GPL

BSD "revisited" license is GPL-compatible, but

http://www.fsf.org/licenses/gpl-faq.html#MereAggregation

Mere aggregation of two programs means putting them side by side on the
same CD-ROM or hard disk. We use this term in the case where they are
separate programs, not parts of a single program. In this case, if one
of the programs is covered by the GPL, it has no effect on the other
program.

Combining two modules means connecting them together so that they form a
single larger program. If either part is covered by the GPL, the whole
combination must also be released under the GPL--if you can't, or won't,
do that, you may not combine them.

What constitutes combining two parts into one program? This is a legal
question, which ultimately judges will decide. We believe that a proper
criterion depends both on the mechanism of communication (exec, pipes,
rpc, function calls within a shared address space, etc.) and the
semantics of the communication (what kinds of information are interchanged).

If the modules are included in the same executable file, they are
definitely combined in one program. If modules are designed to run
linked together in a shared address space, that almost surely means
combining them into one program.

By contrast, pipes, sockets and command-line arguments are communication
mechanisms normally used between two separate programs. So when they are
used for communication, the modules normally are separate programs. But
if the semantics of the communication are intimate enough, exchanging
complex internal data structures, that too could be a basis to consider
the two parts as combined into a larger program.
- --
Ram?n Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBdYaQw4Wp058o43cRAq+wAJ4+BISSW8RTPLIoW5SWgnU9GwgPJgCeNKUY
lGiMA0vZgcS48T7Gr7uvfuw=
=Pfg5
-----END PGP SIGNATURE-----
