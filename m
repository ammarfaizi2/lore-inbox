Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSCYNLD>; Mon, 25 Mar 2002 08:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSCYNKx>; Mon, 25 Mar 2002 08:10:53 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:19467 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S312418AbSCYNKq>;
	Mon, 25 Mar 2002 08:10:46 -0500
Date: Mon, 25 Mar 2002 13:07:35 +0000
From: Chris Wilson <jakdaw@lists.jakdaw.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Ethernet interrupts getting processed as timer interrupts
Message-Id: <20020325130735.6fbc56a0.jakdaw@lists.jakdaw.org>
In-Reply-To: <20020325122129.27f43448.jakdaw@lists.jakdaw.org>
Organization: Hah!
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Mon__25_Mar_2002_13:07:35_+0000_0886d0b8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__25_Mar_2002_13:07:35_+0000_0886d0b8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Stuff I forgot to mention :)

This is an SMP System (2x PIII 550).

& output from lspci -vv attached.


Cheers,

Chris

-- 
Chris Wilson
jakdaw@lists.jakdaw.org


--Multipart_Mon__25_Mar_2002_13:07:35_+0000_0886d0b8
Content-Type: application/octet-stream;
 name="lspcivv.gz"
Content-Disposition: attachment;
 filename="lspcivv.gz"
Content-Transfer-Encoding: base64

H4sIAHMvnzwCA+1Y23KbSBB9lr6iH+VC2MOArhVlS7ckVCxbK8XZ1Lr0MIKRPGUE2mGURPn6bUDC
uluK7WyyFVVhwPQMcPqc7jMQUiXknMC7IFQwlMId8yrYvuIeNAM5DSRTIvDBskjj08Xfn0CHMrUs
MzlZGQS5+tsuuCJkQ4+7Z5CT/DMQ8yybaQa+koGHs15c69DhEw0as7DDQsWlBv0pd5pzx+Pxpb/s
q486fHxb7/tBMNWhy2RbSh36ik+nwh/jUbvX0+ANjm7Qhp7N9BVTs7AKTYbhxWLn7psON603ehqS
ztFqf+y3L2sT7orZBF5/qA8DqXR4lR504gMNXkf3wPNutMtmLpnivjOvQtHKZnp8HMFBqtHTBnIO
TMGrmc/CUIx97r6GnEn1oVB5mEo+4sq5i/A4g9tQfOM1Wih2BtksQcwtxNzu1w9AXqZmyag3oGvb
n6w4NsGUbmCq7cdUOx5T/QRMtVMx1fdiSpZoGGC32iAQBTlizjGAYHgCiIFsm8pgrIsRlAncJjAM
dsGkP5V6/xFMJk2pZ8VvA4iKCiP2GSR655heRjElF4WbfgMW7+9x+TieUfw2ngTnvnnXtB9DU/8F
0IwQkHI2VVXAR4AWyGCmuAsqALv3JxiVAxgXlxibNMXYhMaR4q03u/aR6v0FgfxjA8hKAlAJK1y3
aacVriXGQjEP2v/MxHTCfbUGWKvddO7EFKhhFGjaPdaJeBXICU7gcidw+eD4MngASO241qK9sL4L
pTw4zLnj4AmfQ8Q0IOVsphHdfyrFhMl5jZA8hPjuvhufGXg2w2ld4eM0NULjq7qXzFmjFvI5YvGQ
3wnfTdNA8FfBTY8PRqNRNrNoZRuBI0ajEKKPmDkaxYHdlZ4Gk52jyOI3YuVk9MM/hvEeXyoObSrM
GwIo1FxbQH8VYJfTohxhxpaI9XjI1Sq/MR1sKDyhBEdwbl1nAN3gC5fQYT4b85hZn7kMI1YZ2Uzm
jcfGGNjttJvePeaqb+MfAzeqQ332tTmTEofUKCWTehSVaxE9jwF5DMi3zLtARTsn8FwdKZeyokWi
YL3tR2BE03KvRnDnMA+TEV/D6GWF6HawWJpaoowyKqOt7rj0uQJnpUb3OPMUv4c+n4gozzNHBRJl
cp6HS+WeQ+/DpV42zEqiD4Pg8/Rnw3COfJ9Uoe55AlX4gXs8nPtxUZJ+rC6GUN/4937wxUf1fBYO
B1og5v9IQCbWjIhwfggT4efBKC5O2NezrYJV36z8xVVjt175LUIezNsgjTNWDeCIGSTSyoP58wNf
32MAB1sMLpADDKZ7Gawhg7VVBj/wV0P+4ka1hL/a9/F3wdbKPrbu6nqFQglu0+iuDJCl+HpJPS+v
83V7fDyw/RWRC0Po9q4vcLC2ikrdZVNM5enE1X5W4haLkKOrxLUeiLu7JzxG5tLuVUpEUnIUSa33
azzfcEKpHorWQxhdvxM58k4GroYymG/mx1zvXXe21lO3yyXlYHXMKT1gt4K0F1YQTTpArCAXFYT0
Q/FMpkj0qHmu6qgpMJ0hXAZj4cDbFhQsq5goxipsOCCcZbAuonf8i8eV0rvMuWfSRTnhPfz5Vr3H
fBhPcZ7aMzhP/cmy2UlsZ5Nuu6hm0s6B6m0cL4wT6WrS99GCwagSuuGHd5RPUimSXhduBe4BDzrC
kQHm38F6GMiLxEwMfjp3/PKr32PcsbHmjulhdxwtqLd86JLRR/nQRU4NsOn1o8ncyuXOJBrfJ22D
OO7pn9m0Z/3M9gOy/VjfK+/re+UjyoPVeYq0zZeySCdQYPjbFB0gR2UfOcxnMEUV6xhTRH+botQU
GckH8H6zb0OIa1x8vDXd9OeToQiWnsj2nXPIjbC/cenN4arZO4OC6ZQrhfSL5XeqJvoc8cNU80Ke
KFUNtUqQKxV2L4Kfoaauc54ctTA2T1oY7xaOeYI9y/4Lr37hw9AaAAA=

--Multipart_Mon__25_Mar_2002_13:07:35_+0000_0886d0b8--
