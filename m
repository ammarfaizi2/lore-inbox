Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbQKACX7>; Tue, 31 Oct 2000 21:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQKACXu>; Tue, 31 Oct 2000 21:23:50 -0500
Received: from [200.230.208.16] ([200.230.208.16]:29203 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S131095AbQKACXl>;
	Tue, 31 Oct 2000 21:23:41 -0500
From: "Carlos E. Gorges" <carlos@vb.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ipac usb abnt2 (others?) keyboard fix
Date: Tue, 31 Oct 2000 23:46:26 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd"
MIME-Version: 1.0
Message-Id: <00110100263206.01274@quarks.techlinux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi all,

This fixes "/" key in abnt2 ( pt_BR ) keyboard of ipac ( compac computer ).
2.2.17 fix need a suse usb backport patch ( I use test2-pre2 ).

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: application/x-gzip;
  name="ipac-usbabnt2-2.2.17.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ipac-usbabnt2-2.2.17.diff.gz"

H4sICMV8/zkAA2lwYWMtdXNiYWJudDItMi4yLjE3LmRpZmYAlZDLasMwEEXX1lfM2vJYYyeWirtx
CIVC8yIuZBlcP6ipiYNCQrrov9evhDppSioGaRZz7pGU5FkGuNdQ5Jv9EV3btR0lEp0fUr0T8Xuk
xTZef6Sfb3bcm8E40kW5uzHKEPGeSGOVJjArDwAOEPkk/aEHLhExzvk/fBc5ztAfyDYnCADdgWcp
4O0RBAwAyOrqidbTcLLqmuWpeZ12AwY0S5hAR+8Bqy0DU/Qi+mUYPxFJFSLVX0jtG42Xc6sP1i7Z
uPBOl6pdqnHxK6SyvCzCySh8PrO/ozdfdiGr76fav/h6ZMC+AdVIwadKAgAA

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: application/x-gzip;
  name="ipac-usbabnt2-2.4.0-test10.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ipac-usbabnt2-2.4.0-test10.diff.gz"

H4sICGJ+/zkAA2lwYWMtdXNiYWJudDItMi40LjAtdGVzdDEwLmRpZmYAlZBdT8IwFIav219xrum6
nnWwyrwZMSYmMjGMhEuC3RYXCTPdIHjhf3dfGCdgsDlpz8V53qdtnKUp8J2BTbbdHbi0hzbyMilK
B0Vssn1iCqFf10a869Vb8vFi6zOTXK/NJi8uAJRzfn08CfMtzHQJ0gWJ/sjxXa9qEClj7N9uskxi
eMr3AA4g+tLxh+M2LQiAS3dsKWDtEQQUANDq6h5XYTRdds382CzCboBAs8QA8DC64dWWwkD0IvpF
yE/Ewwrx1F9I7ZvczWdWH6xdXuPiV7pU7VKNi50gleXxOZpOoodv9jx68WW/ZPX9VPsXn7cU6BfB
BjFcYgIAAA==

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
