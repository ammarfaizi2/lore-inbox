Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUFLNhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUFLNhV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFLNhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:37:21 -0400
Received: from [217.78.6.154] ([217.78.6.154]:59780 "EHLO zapp.gurgleplex")
	by vger.kernel.org with ESMTP id S264774AbUFLNhU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:37:20 -0400
From: David Connolly <slarti@netsoc.dkit.ie>
To: Manuel Arostegui Ramirez <manuel@todo-linux.com>
Subject: Re: new kernel bug
Date: Sat, 12 Jun 2004 14:37:34 +0100
User-Agent: KMail/1.6.2
References: <200406121159.28406.manuel@todo-linux.com> <40CAF817.3080103@ThinRope.net> <200406121442.48691.manuel@todo-linux.com>
In-Reply-To: <200406121442.48691.manuel@todo-linux.com>
X-GPG-Key: http://www.netsoc.dkit.ie/~slarti/pubkey.asc
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406121437.44155.slarti@netsoc.dkit.ie>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 June 2004 13:42, Manuel wrote:
> I'm thinking about download patch-2.6.7-rc3, maybe it will fixed that bug.
> Any ideas?

I use 2.6.7-rc2-mm2, and the crash.c program produces the console race,
2.6.7-rc3 maybe not worth the effort mate.

How would I go about trapping SIGFPE to prevent end users of login server 
crashing the box, can anyone point me in the direction of advice? We really 
don't want to have to disable user logins! 

Thanks,
- -David Connolly
admin2 on netsoc-dkit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAywcjHyDWKYgIFNcRAkcKAJ9rrp7s2h5HZhVP9/7OpMtGzljgAACfaEIx
Ph+ubI+G3sJPC80AYhDqVnw=
=0EFM
-----END PGP SIGNATURE-----
