Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423002AbWJRVdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423002AbWJRVdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbWJRVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:33:35 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:37019 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1423002AbWJRVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:33:34 -0400
Message-ID: <45369DAB.5080000@comcast.net>
Date: Wed, 18 Oct 2006 17:33:31 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: nobody cared about via irq
References: <45366556.7010907@comcast.net> <1161195903.21484.16.camel@localhost.localdomain>
In-Reply-To: <1161195903.21484.16.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Sergio Monteiro Basto wrote:
> Maybe the best is report on bugzilla and attach dmesg, lspci and
> cat /proc/interrupts 
> 
> see if 
> http://bugzilla.kernel.org/show_bug.cgi?id=6419
> match :)

Oh yes, that looks exactly like it.  :)  Apparently I didn't file an
Ubuntu bug before (was sure I had long ago...), so I've done one and
linked it to kernel bug #6419.

> Let me know if you do a bugzilla report 
> --
> Sérgio M. B. 
> 


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTadqgs1xW0HCTEFAQJ5txAAgEFsNEIjyGIgk6Gvi2lfeMa5YSV7wgxP
WuDuYyAJh5SL9DjVcz3pI2tzCkce6oIrwT97RWC97kXifiUCA3RZWJmobrouznRS
quIRcqmiTF/nEKcM6n7k33IhNICSzEnS+kS00v/aeqM+AGSdXAbtrqyAkBIVeMdA
CgO0o/F8ONBpXdxnFVl/RYJPaXBgDiP9rYQtof4BERnDJJBSqt1u6EXAOtjcPjqP
lbUXO/SSJfKZAgnfhWYS1GlRZ1qlCuRr1q/1L9aQt2Mzq62NDGjHj6w9FM2M9wth
eAjtfAhX6lsvGRCf8//1oCg5i3MU2F9YsTTih/but+Znca/o86gtRbsSZ8Eg+CLA
XYsT0QaomZPtM1qHRkf369SkAJFobob4kxCzN6v3xBFoPfSLuh+0ZfRYIic2mfPN
xiB/3gfHMA/ReFE8pAPhQ9WMk/2gRg3aL7YBd3MTH/4eUVsv8ImtYfJrlUsYSdjh
mhkpTzmLCkXOIV1HzbnazKro7jufNsXVPtKLuZwmCatnplDDueTb5dLeWhFd+dRg
I6XHrKl9pfMCJEEtoEz2UOp7bOB3AmI8N/EX+gSrohL9GwFPuv8jTO0ZwmSBfzuK
GKrTmd8ya7ysUm9x7SqikTPyirkU4mt33euqv9w8jztLW999AwcXA703lknu6PWZ
XHm3mP8TrF0=
=VvjZ
-----END PGP SIGNATURE-----
