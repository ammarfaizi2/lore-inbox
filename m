Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRIHTWC>; Sat, 8 Sep 2001 15:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271799AbRIHTVx>; Sat, 8 Sep 2001 15:21:53 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:41659 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S271795AbRIHTVl>;
	Sat, 8 Sep 2001 15:21:41 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Sat, 8 Sep 2001 15:21:55 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Clarification of 2.4 VM Logic
Reply-to: jlmales@softhome.net
Message-ID: <3B9A3793.29128.408829@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am not part of the Kernel Mailing list.  It would be greatly
appreciated if I was copied in on any replies.

I have successfully compiled the 2.4.9-ac9 version of the Kernel.  I
have read the details of the different VM paging varients as noted
via the http://linux-mm.org/wiki/moin.cgi/PageAging.  I have been
following via LWN the issues and thoughts of the VM issues for the
2.4 kernel.  After reviewing the "Page Aging" descriptions I choose
to try "4 for PAGE_AGE_EXPUP".  I have not had alot of time to abuse
or use my system with this paging logic as yet, but the initial paces
I have had the system through as a workstation suggest some promise.

The clarification I want to seek is is the current method/logic of VM
in the kernel just as noted per
http://linux-mm.org/wiki/moin.cgi/PageAging or is there more to the
logic than documented there?  I ask, as I have some thoughts
respecting paging logic.  As I am not familar with the kernel
internals, let alone remotely close to the required C/C++ skills to
even modify most code, I could not answer this question myself, let
alone experiment with the kernel code to see if any of my thoughts
might be of some value.

So before I ramble on with some possible thoughts, I thought I ask
for the clarification in order to have a reasonable reference point
to the thoughts I had.


Regards,

John L. Males
Willowdale, Ontario
Canada
08 September 2001 15:21
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO5p9xuAqzTDdanI2EQIszgCfSIrVg3Ca87SRuY3Wjp+4DS/VxBAAnAgH
ExgeFIQF5L2oQAoX1wIKUeZ4
=GBth
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
