Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSJ3PuA>; Wed, 30 Oct 2002 10:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJ3Pt7>; Wed, 30 Oct 2002 10:49:59 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:34826 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S264711AbSJ3Pt5>; Wed, 30 Oct 2002 10:49:57 -0500
Date: Thu, 31 Oct 2002 00:55:35 +0900 (JST)
Message-Id: <20021031.005535.67557509.yoshfuji@linux-ipv6.org>
To: boissiere@adiglobal.com, davem@redhat.com, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3DBFB0D2.21734.21E3A6B@localhost>
References: <3DBFB0D2.21734.21E3A6B@localhost>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DBFB0D2.21734.21E3A6B@localhost> (at Wed, 30 Oct 2002 10:13:38 -0500), "Guillaume Boissiere" <boissiere@adiglobal.com> says:

> o in 2.5.45  IPsec support  (Alexey Kuznetsov, Dave Miller, USAGI team)  

How is the status of IPsec for IPv6?


> o Beta  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji 
> Hideaki, USAGI team)  

We've almost done.

One thing that I'll contribute before the feature freeze is:
  - Privacy Extensions for IPv6 addrconf

The remaining things which we DO want to see in 2.6 are:
  - check is "rmmod ipv6" is ok
  - IPv6 source address selection; which will be mandated by the 
    node requirement.
  - IPsec for IPv6
  - make IPv6 non-experimental :-)
  - several enhancements on specification conformity
    (neighbour discovery etc.)

Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
