Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbQKJMLH>; Fri, 10 Nov 2000 07:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbQKJMK5>; Fri, 10 Nov 2000 07:10:57 -0500
Received: from web1101.mail.yahoo.com ([128.11.23.121]:22283 "HELO
	web1101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129990AbQKJMKp>; Fri, 10 Nov 2000 07:10:45 -0500
Message-ID: <20001110121043.16693.qmail@web1101.mail.yahoo.com>
Date: Fri, 10 Nov 2000 13:10:43 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: [PATCH] 2.2.18pre21 : Megaraid
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-559412924-973858243=:13224"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-559412924-973858243=:13224
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Alan,

I've patched the megaraid driver with these 2 lines
taken from RH7.0 2.2.16-22 kernel, and now my netraid
no longer hangs at boot. I don't know if this can
induce side effects, but it works again here.

Regards,
Willy



___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
--0-559412924-973858243=:13224
Content-Type: application/x-unknown; name=patch-megaraid-ok
Content-Transfer-Encoding: base64
Content-Description: patch-megaraid-ok
Content-Disposition: attachment; filename=patch-megaraid-ok

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5jCVdlZCBOb3YgIDgg
MTY6MDI6NDUgMjAwMAorKysgbGludXgvZHJpdmVycy9zY3NpL21lZ2FyYWlk
LmMJRnJpIE5vdiAxMCAxMjowMzowNSAyMDAwCkBAIC0xOTIwLDEwICsxOTIw
LDE0IEBACiAKICAgICBwY2lJZHgrKzsKIAotICAgIGlmIChmbGFnICYgQk9B
UkRfUVVBUlRaKQorICAgIGlmIChmbGFnICYgQk9BUkRfUVVBUlRaKSB7Cisg
ICAgICAgbWVnYUJhc2UgJj0gUENJX0JBU0VfQUREUkVTU19NRU1fTUFTSzsK
ICAgICAgICBtZWdhQmFzZSA9IChsb25nKSBpb3JlbWFwIChtZWdhQmFzZSwg
MTI4KTsKLSAgICBlbHNlCisgICAgfQorICAgIGVsc2UgeworICAgICAgIG1l
Z2FCYXNlICY9IFBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0s7CiAgICAgICAg
bWVnYUJhc2UgKz0gMHgxMDsKKyAgICB9CiAKICAgICAvKiBJbml0aWFsaXpl
IFNDU0kgSG9zdCBzdHJ1Y3R1cmUgKi8KICAgICBob3N0ID0gc2NzaV9yZWdp
c3RlciAocEhvc3RUbXBsLCBzaXplb2YgKG1lZ2FfaG9zdF9jb25maWcpKTsK


--0-559412924-973858243=:13224--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
