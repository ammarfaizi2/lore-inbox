Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJTMoP>; Sun, 20 Oct 2002 08:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSJTMoP>; Sun, 20 Oct 2002 08:44:15 -0400
Received: from freemail.agrinet.ch ([212.28.134.90]:27916 "EHLO
	freemail.agrinet.ch") by vger.kernel.org with ESMTP
	id <S262454AbSJTMoO>; Sun, 20 Oct 2002 08:44:14 -0400
Date: Sun, 20 Oct 2002 14:50:13 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] 2.5.44 Typo in include/linux/pnp.h
Message-Id: <20021020145013.4e609712.starfire@dplanet.ch>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.8.5claws20 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__20_Oct_2002_14:50:13_+0200_09f14680"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__20_Oct_2002_14:50:13_+0200_09f14680
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Heelo World,

The attached patch corrects a typo in include/linux/pnp.h (A ')' instead
of a '}') that avoids compiling.

Regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 

--Multipart_Sun__20_Oct_2002_14:50:13_+0200_09f14680
Content-Type: application/octet-stream;
 name="pnp_h.patch"
Content-Disposition: attachment;
 filename="pnp_h.patch"
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvbGludXgvcG5wLmgub3JpZwkyMDAyLTEwLTIwIDE0OjI3OjA2LjAwMDAwMDAw
MCArMDIwMAorKysgaW5jbHVkZS9saW51eC9wbnAuaAkyMDAyLTEwLTIwIDE0OjI5OjI0LjAwMDAw
MDAwMCArMDIwMApAQCAtMjQ1LDcgKzI0NSw3IEBACiAKIC8qIGp1c3QgaW4gY2FzZSBhbnlvbmUg
ZGVjaWRlcyB0byBjYWxsIHRoZXNlIHdpdGhvdXQgUG5QIFN1cHBvcnQgRW5hYmxlZCAqLwogc3Rh
dGljIGlubGluZSBpbnQgcG5wX3Byb3RvY29sX3JlZ2lzdGVyKHN0cnVjdCBwbnBfcHJvdG9jb2wg
KnByb3RvY29sKSB7IHJldHVybiAtRU5PREVWOyB9Ci1zdGF0aWMgaW5saW5lIHZvaWQgcG5wX3By
b3RvY29sX3VucmVnaXN0ZXIoc3RydWN0IHBucF9wcm90b2NvbCAqcHJvdG9jb2wpIHsgOyApCitz
dGF0aWMgaW5saW5lIHZvaWQgcG5wX3Byb3RvY29sX3VucmVnaXN0ZXIoc3RydWN0IHBucF9wcm90
b2NvbCAqcHJvdG9jb2wpIHsgOyB9CiBzdGF0aWMgaW5saW5lIGludCBwbnBfaW5pdF9kZXZpY2Uo
c3RydWN0IHBucF9kZXYgKmRldikgeyByZXR1cm4gLUVOT0RFVjsgfQogc3RhdGljIGlubGluZSBp
bnQgcG5wX2FkZF9kZXZpY2Uoc3RydWN0IHBucF9kZXYgKmRldikgeyByZXR1cm4gLUVOT0RFVjsg
fQogc3RhdGljIGlubGluZSB2b2lkIHBucF9yZW1vdmVfZGV2aWNlKHN0cnVjdCBwbnBfZGV2ICpk
ZXYpIHsgOyB9Cg==

--Multipart_Sun__20_Oct_2002_14:50:13_+0200_09f14680--
