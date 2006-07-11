Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWGKEHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWGKEHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWGKEHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:07:36 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:36348
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S965008AbWGKEHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:07:36 -0400
Message-ID: <001701c6a49f$859e3090$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <James.Bottomley@SteelEye.com>, <rdunlap@xenotime.net>,
       <hch@infradead.org>, <brong@fastmail.fm>, <dax@gurulabs.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <robm@fastmail.fm>
Subject: areca-raid-linux-scsi-driver-update7-fix-3.patch 
Date: Tue, 11 Jul 2006 12:07:24 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01C6A4E2.922C78B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 11 Jul 2006 04:00:42.0140 (UTC) FILETIME=[93FF2DC0:01C6A49E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C6A4E2.922C78B0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit

From: Erich Chen <erich@areca.com.tw>

  1- fix the return value of sysfs read / write

Signed-off-by: Erich Chen <erich@areca.com.tw>

Best Regards
Erich Chen
------=_NextPart_000_0014_01C6A4E2.922C78B0
Content-Type: application/x-compressed;
	name="areca-raid-linux-scsi-driver-update7-fix-3.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="areca-raid-linux-scsi-driver-update7-fix-3.patch.gz"

H4sICOHltEQAA2FyZWNhLXJhaWQtbGludXgtc2NzaS1kcml2ZXItdXBkYXRlNy1maXgtMy5wYXRj
aADNV21T20YQ/iz9ik0+MJYt2ZKMDbULE+OYKdMAid2k7UxnbmTpZBT04t5JvEyhv717JwnbwhhI
QwbNWC+nvb1nn2d3Tz5kSdSDEQvcMxie0Rh+puL+ncOo6zTdJGqml/uqCmAZ4AdXkJ5RYDTNWAwX
TphRSHzg19znOOp40IJLFqRUVSfBLKaekfi+Mb1+fAHDMFTwWHBBGW9xlwcth7kRZ8WFOGnKmi7c
AECnA43qYSwOFSwEGlIO7pkTz6inQ7sDQcwpS4Mk5rWGpoNtgkdDmg8YmirWhzCIs6vWoyCaCZsp
tml2DXPHsGwwt3vtds+0m2Z5gGF2TVNFXE/1ueKv07N3e3bnnr9378DYMfVdaMgzPhY+JP8kSOYk
opw7M0qEFjWessxN4TyZqqBkQZzukhTq80/TzPcp0+vzNCof+miBBm0bLZwwvMIhEqJWe2DiK9VQ
Ah9qb1xn7kxDWhsOPpLJnxMyeH98dKLBzQ3UUGdogJtkcarBPlhm25bjcgS2tjBNfA320J+G3pQi
g9B5Y5NrDV+XtsZoMByOJgIOKK06eAkU0UIWB6lMvybUW/h2KTCMoHYXuoZjfUmjZXX0n6AhLpa5
kUmZzgsql3iKrgmN5um1IEqHjOeU6XD5Ny5D/IDxNIg9elWOhE4x0F8rB0g9hJs7SV6Sd+MbmM9n
5K7ztVbNjk6+DD7018sjeVzSZxHoGomQH36XgbWCcE0uXOhnd/Qd1M/u4uV58lXlwRUcd2rsV8dl
SWC4FfHgzd49hTX4B42VAsQ84SkpVK2ha61fzfjFAzIVU+qJjsquJTe3QENOc4fLGSaIqK5rVLEZ
YGlioqJs1Qbj4fFkTI4Hf5BPB58PD0dj+brgb7sr+dveeTZ/inIrz0UMhSg4cofcUCrhbopXesPf
bY6ra4n+ZnXtRxqcG1KHreAq7o9zg88i5whOiWgEdUZnpczzKFtbf08rtxdqZ2KORIcn4ofOjMMW
DIYH5JAcnX58P/htQE6/jMaHH05/L3OtYr0H/663z/W2bUu3u9CwbVtvtwWzGH/JLjb8xC04FttR
SevAc+apxEcZS0Sd5jYuttqUkmkQE7HR1rbOMOONfS4uKIzDuUcvmrjtfNWLZFyRcXmPkuvJAhEU
yGW0gsP8AaNFzuYM4Z7Xfh2NT8hoPIa3ucMeSOjF90eUSZfgOwjK+yt+q8m0nCVpAtLZHeIVCHkr
vH2pKGUBfecwpc/nxCknvHCgsiK/c6DS53MClRMWgS7qcuOEHuLNg2E0Si6eyEWjwuNz5j41YRqr
PD5M3FoID+TKpiR5VVQsd4j/z8T95rChK/QW2SOt+uUOZW/v6lYbO2mnq9vy03Gzl4sk8NSy0/qM
0ocaLWXDJE5ZEh5gCZxDXXw5yF5fGE3wvwP5BQmEuqCx3M/EvWQH+3mJ9DVpWGkL34LricILcje1
jh9Rrz8wwPuF/ZqqcIH1gY35VnxYqP8BjF6EcH4QAAA=

------=_NextPart_000_0014_01C6A4E2.922C78B0--

