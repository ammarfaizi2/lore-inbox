Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbQLHPr1>; Fri, 8 Dec 2000 10:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132119AbQLHPrR>; Fri, 8 Dec 2000 10:47:17 -0500
Received: from web1102.mail.yahoo.com ([128.11.23.122]:52749 "HELO
	web1102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131652AbQLHPrH>; Fri, 8 Dec 2000 10:47:07 -0500
Message-ID: <20001208151632.17335.qmail@web1102.mail.yahoo.com>
Date: Fri, 8 Dec 2000 16:16:32 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Linux 2.2.18pre25
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Willy Tarreau <wtarreau@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Miquel van Smoorenburg <miquels@cistron.nl>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-87755422-976288592=:13116"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-87755422-976288592=:13116
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

> It doesnt even apply

sorry Alan, I think it's because I had to copy/paste
it
with my mouse under X into my browser (I don't have
smtp access here at work), and it applies here with a
-12 lines offset...

Here it is attached for 2.2.18pre25, but since the
raid
server is running now (under 2.2.18pre20+patch), I
won't be able to test it till next week, but
I'm a bit confident since it will do the same as the
one which currently allows this server to boot.

as soon as I can reboot it, I promise I will test the
kernel with and without the patch to be really sure.
but before that, if people who have problems with
megaraid/netraid could give it a try, that would be
cool. Also, it would be nice if people for which the
normal megaraid driver works would accept to check
this
doesn't break anything.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
--0-87755422-976288592=:13116
Content-Type: application/x-unknown; name=patch-megaraid-fix
Content-Transfer-Encoding: base64
Content-Description: patch-megaraid-fix
Content-Disposition: attachment; filename=patch-megaraid-fix

ZGlmZiAtdXJOIGxpbnV4LTIuMi4xOHAyNS9kcml2ZXJzL3Njc2kvbWVnYXJh
aWQuYyBsaW51eC0yLjIuMThwMjUrbWVnYXJhaWRmaXgvZHJpdmVycy9zY3Np
L21lZ2FyYWlkLmMKLS0tIGxpbnV4LTIuMi4xOHAyNS9kcml2ZXJzL3Njc2kv
bWVnYXJhaWQuYwlGcmkgRGVjICA4IDE2OjEwOjI3IDIwMDAKKysrIGxpbnV4
LTIuMi4xOHAyNSttZWdhcmFpZGZpeC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQu
YwlGcmkgRGVjICA4IDE2OjEyOjA3IDIwMDAKQEAgLTE5MDgsMTAgKzE5MDgs
MTQgQEAKIAogICAgIHBjaUlkeCsrOwogCi0gICAgaWYgKGZsYWcgJiBCT0FS
RF9RVUFSVFopCisgICAgaWYgKGZsYWcgJiBCT0FSRF9RVUFSVFopIHsKKyAg
ICAgICBtZWdhQmFzZSAmPSBQQ0lfQkFTRV9BRERSRVNTX01FTV9NQVNLOwog
ICAgICAgIG1lZ2FCYXNlID0gKGxvbmcpIGlvcmVtYXAgKG1lZ2FCYXNlLCAx
MjgpOwotICAgIGVsc2UKKyAgICB9CisgICAgZWxzZSB7CisgICAgICAgbWVn
YUJhc2UgJj0gUENJX0JBU0VfQUREUkVTU19NRU1fTUFTSzsKICAgICAgICBt
ZWdhQmFzZSArPSAweDEwOworICAgIH0KIAogICAgIC8qIEluaXRpYWxpemUg
U0NTSSBIb3N0IHN0cnVjdHVyZSAqLwogICAgIGhvc3QgPSBzY3NpX3JlZ2lz
dGVyIChwSG9zdFRtcGwsIHNpemVvZiAobWVnYV9ob3N0X2NvbmZpZykpOwo=


--0-87755422-976288592=:13116--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
