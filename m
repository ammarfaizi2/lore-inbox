Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273739AbRI3QdE>; Sun, 30 Sep 2001 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRI3Qcy>; Sun, 30 Sep 2001 12:32:54 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:63429 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S273739AbRI3Qce>; Sun, 30 Sep 2001 12:32:34 -0400
Date: Sun, 30 Sep 2001 18:29:41 +0200 (MET DST)
From: Oliver Seemann <oseemann@cs.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 nic dies with load (2.4.10, kt266)
Message-ID: <Pine.SOL.4.10.10109301821550.13725-101000@gorisa>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1001867381=:13725"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1001867381=:13725
Content-Type: TEXT/PLAIN; charset=US-ASCII

ok patch applied (and recompiled ;). but error still occurs.

after copying 300mb in 50 seconds over samba it's stuck again :/

dmesg output attached.

(meanwhile i exchanged the nic with another one from lcs with rtl8139
chip, but didn't help)

Oliver

---559023410-851401618-1001867381=:13725
Content-Type: APPLICATION/octet-stream; name="out_n2.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.10.10109301829410.13725@gorisa>
Content-Description: 
Content-Disposition: attachment; filename="out_n2.gz"

H4sICLBFtzsAA291dF9uMgDtWktv4jAQvvdXzLGVaGWDQ8JKe9hHD72stFUP
e0PGNgVtCZUxWrS/fp2WV1o7CbHZQmIOiDgw/mbG880jIHRzIdVTgnuD4TRV
Qsrls/oEQk2Qfl9N1TR9hO2NTvZRDheKquXiM1oh/Sr4/XYBYP8nBCj7nS28
XkaQij/Zd3dLeCdUrt7LvUthd/vyqgNsKaVIFZARTuDrcvyFc6kvItaBsRQC
1FxfoaQD32YcECuWnpO9Bg4EEQ2rA4vpXwFaBfSy6cuGxdK+z1NhRRsxK1rC
1mj54QZGeQOj9wb26HW9LNVwNZtuBfxciqXg8LCCZ41DKKAKOCe9OOnTVwPi
CJNMzcXTXEENWd0+R0ZZ2Pk0ksOMdQoeCJqWgMI+GSYXsxQZY9Yrw0Ql0goZ
hiIr2gFqGMNoVjAzTLeNsVLdaqMtl8b9aGu0XhuNFjT9n1SaIydBjOTklUop
cqBSQaxoOTkTKj0Fr+/bkXUTox29el2Q+l7XAG1oGU6C16t6PW9HarZjHa/H
g5zX48Ha63pDB69TO9rBuXi9TgHg3piNzCUYPk4559wwtrLK8dmyt8dqQdP2
anrMzJjLNYIZc43Pekhv6JAZBbOi5Q0cWZaOGatnIGGWFYYTxVYzZ6BW5u1T
YKv9+Oc9ZIx/r2wlHMafGqANLe+e9PiTtPF8V2cF5rFjYaUdS3s8UFNTn49w
8zEbE2PM+mQYvaEDw8TEirZ/LlNB5y66XkceMnvQ9CNqmHzMjhJjzHplmNhh
Aq0BWtHSBs4iPf5JxDLXDJn9g+Ju/yQLRIwnuVbc9fNx19/E3chh0qEBWtGO
m5fZLX22+3TCZ22Y90mEjD7xeYIEKmFuozRMI0I56q7lZZcbeVG+1tTCNpJu
1UTIVDtkLOlMwIRy0HfnctF5K3bPvUJlUmZzLrSAHw+39+Zba6xguHmJEepd
Ac8i4foa7lfA5ul4+gho/bq5EBmyIZNss8f+wq+7hw5IoZYyzc5lFxOsTUni
yAJSf78p8M894sMTsaBpgzX1OU0KVqtstVZW185WC0+B6lgt5KoJPlInhwvq
cEzJrg7HNNmbSWDaq1KH48MmKNmGxdIKOrkMoBVtXDpBqWzgQ7yOXWMF259Z
C8G6rwbsVWBlu3oOkXKaNgsVwPFOGirPZE0+aafAyTmWY8zIcl45OSmarpVx
MmNWtKPS/xGdiNcdOdlavTQ5UkJ/cQgn/wNP0Vvjnz0AAA==
---559023410-851401618-1001867381=:13725--
