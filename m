Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSFRXgm>; Tue, 18 Jun 2002 19:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSFRXgl>; Tue, 18 Jun 2002 19:36:41 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:10764 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317674AbSFRXgj>; Tue, 18 Jun 2002 19:36:39 -0400
To: F ker <f_ker@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] vfat doesn't support files > 2GB under Linux, under Windoze it does
References: <20020617225149.56796.qmail@web14604.mail.yahoo.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 19 Jun 2002 08:36:17 +0900
In-Reply-To: <20020617225149.56796.qmail@web14604.mail.yahoo.com>
Message-ID: <87sn3kf9ce.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

F ker <f_ker@yahoo.co.uk> writes:

> > 
> > This patch break some filesystems (adfs, affs, hfs, hpfs, qnx4).
> > And I haven't fixed them yet. So, I can't submit this patch.
> > 
> > If it's OK, I'll make the patch for 2.4.18.
> 
> 
> Any update on the patch yet?

Whether it's needed, there is patch of fat for 2.4.18 and 2.5.19, here.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=fat_big-file-2.4.18.diff.gz
Content-Transfer-Encoding: base64

H4sICO90Dz0AA2ZhdF9iaWctZmlsZS0yLjQuMTguZGlmZgDVV21v4kYQ/mx+xdxJd7UBg3lNgAMl
dyVV2iRIR6/XD5UsY69hVeO1vOsctGp/e2fXBgwYJ6rUD42SOOw+M7OeeXbmiUd9H8wkfoKAhsnG
bDe6jdZ10+fNReL7JG644DvCXtCl6dOAFOxXTNO8aKz9nBC4Iwto98HqDjvXQ+sa2pbVrtRqtZc8
a1+JBz8mIbQGYLWH3f6w10+Nb27AbF1ftetXUMueNzcVgCp8JbB2trByngkIBmQjSOiBWBGQQRoS
06xAxaShAJeFwo5iEjkxsb/FVBCdizhxBUTOkkBV/q5DEnK6DPEkzPc5EbkFweqwJPgKAXN/twVU
9x9yoICFS6gutoJwo1L7r8MGiJZLWTz4swJa5tzxvJhwbvPIcTHK2okiikcbq6jmJPs8OhjQkHkI
TB9jyADmZMW4GFW8i8TBqjZVsi9S54AoJM9hW3tkIdwmS2h1JAN6Owa0yuiTMy8lUF/Rp78jj/YX
/lAf9DduTBxBMHuaFhORxCFYo4qp9qjKM3z4AHxhTniadk7/IHgQweHNGB7n38/m9r2u0mZgXtcJ
Fps+S49YjlreTTkcJpPCKIaqqvbxyw+6Mcod0pzez0bqPcpro0KVFyeDXKxOtv+vbnfe/qQ+g2Gv
fahP1+rLAqWPQ4WkqTmhmBSVEmRmK60HNSdukHBBYpWm0TFYZhCxur5fU9Y1OHNoQsvAcmsaALyH
v/VCgCGrMxhhPfc4Pb18RiketNOKUztgSy6cWODxrCJEnhNjODo/wlMud3v1PpIZH9dprjSVEFmD
gIRLsULLT3f2w9R+0BdqvdPOdlISKXjMmLCzJB4b5HekgXzxlJxrZ6O6jTz9xs++MDGHM3Aa+szm
xBXs4PWr9JrbSE/RrMLjJ0wYXpK8EeVg1cFj4XcC1kkgaBRsYbEFS3VzTd2polh4JEPlZ9BTl33Q
6+64hJHECv3it8PBDRhXA0NOCmx/mC9c/UbAdULZbKHRaKSx/vf822+vBV0fEcpJF2RCPeSa7THe
TkK60XcVkzCJMer5FYk1jCPXbubpciNK1hzdv9SLjlGF7egYogbGDIcXFgU7UrufdaTSgXHionRo
dFBs4EXr7DWHpr3VXbaOMHkLGlCxhYA8kwDeeY13Xh1DcqSs9G/8Fr6tgzT4kl7wX6af5/ezpzpk
nz9PH6a382l2u84u1+Ptr/bT7Ml+uJurIa32WYQ779MXsDmL+KF/zD/ilcDuwSJBWcgbHhN89pPq
MZL8HuXOIiCwop5HwvEYt2VaUnl0oW40RIJ7pKkWMXONVWFKz2HnlTvHnA8THPqlw6TAR7li7AzU
RMmesnpSH+LolLIslVM4+j3bT4LAlrIoL8yqR6qrKst0Zn1R1VUP+i3/V4nDcpX4Cn911UO0EyFq
pC1D2wnFk6hLEpKYuraKTjaRE3p6gRzcC03ZXwwoSgXeiTUVr9C3fszWR+q2MLN8G7pnJVHHfxVX
0wvic5u+irN5+EvczWO1u5gqDrew/fSGrauhZUn+Wa/k8JGvcvGqtOv+/x55aSHLTOpE1cmW0xDl
onlCg5yikHzIinm0Krs5Ft1WykR1DJ/G2Mt26gDHq7WbiBK3EzEKih+o6wQnJjm0I0TMFTQJE47H
kgt0kaDCUUIaof8ARVi5wZoOAAA=
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=fat_big-file-2.5.19.diff.gz
Content-Transfer-Encoding: base64

H4sICEB4Dz0AA2ZhdF9iaWctZmlsZS0yLjUuMTkuZGlmZgDVVt9z4jYQfjZ/xd5LawMGmx8hhAuT
6fXauc6l93Dt3KPG2DJoasuMJN9BO+3f3pVsgx2MQx+bSXAsfbtavm+1uxGLY3Bz8SskjOcHdzKa
j/zlOJbjTR7HVIxCiANFNmzrxiyhLfs913WvGlu/7XJ4Do4w9cCbPswmD7MZTDxv0hsMBq95tr7Q
CH7JOfhLbez5D/PS+OkJXH859YcLGJTPp6ceQH/cgx4wriDMuCJ7QfeBoOSbYIraUok8VLAPthT6
+nMIOZdsy/GULI4lVcOea1mnNZUNYUsxwiQL/yAK+qeXmmGS8S30N0dFpdMb3Gid4HF6qTSDv3pg
ldEFUSSolETugxDDTIP9nuEJjyZsd12+r84GjGcRAovHI5QAd73LpFr1oqvyIvdjzft1gc+IVonP
2y0iL18VuWbeKfN8pkU2n1pi62/8YzHYb0JBA0WRPcsSVOWCg7dC/fQeMzzD27cgN+5aFrRL9ifF
QJSEN4/w/PnHT5/JB9vQ5iCvaY7Zwr5qjyjHoO6mGw7rdespjlHV+uH3n21nVQvSff/h08p8j25t
zFHd4pSQq+qU+5fyzF+/g3X7S33mZ31m/kILVDzOCmlTd82QFEMJZqZf6MHcdZjkUlFhaFo1wZpB
xNr2ac1YD+DCoQu+o6+rBQDfwT92K8DR6ixX+mJWOLu4fE4nHqyXijOSZFupAqEwPK8NUc+JR2jE
j3DD1WIxH97BQD/uC64sQ4jWIKF8q3Zo+e4n8vE9+WhvzPp0Uu4USWTgIssUKUlsGtR3tIH+4kVy
psHBVBsd/SEufwwx2u24D8/vkAHMesbjjEgaqkwAk+ANIcr49wrSPFFsnxxhcwTPFNoqeFk3qcL5
osOpbRTh61vVZoRBOUVR9+6mpqh7d/MqnzA4tcNQ8DeQECaZpFhdcQ0fIkfOcPUbhTDguuDCaDQq
wvvf5+BpO1UsbSRVUCxoSiPMNxJlcpJzdrAr8jVMY5xhfUVjHafhOiw9XSlGjCNRER2bxbIxkx0N
otGutXJ04C/LVAe4paXMu2tWl7POAuYvF8UYURUwPT4UXRs7TETiPEmI7r71AaLfaO59zenZ7OrY
0T8PDvX/2jx1zy83ODKzTG0eKQYVp8hDq5pAquO2lFPBQmKOpYd9wCO7ZcA4jS46Wx1ofOswS1Om
bpi1YpGltVeVNdmTRx5e8G0ivSlHU4mXgcSSsJtStA5/LUPr2P/eVDt8Xebn3Tk/73V23jcn3JKZ
wolRhuh6iiOH+0LxWlfS0pfyNVZ1NUCZieluK11uYyYkpmDZYbBAe1VF1biqERoovrAwSF6Y1NCB
UkIaaM5ziWHpBbbJsUuaYQyh/wL6Gm1phAwAAA==
--=-=-=--
