Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbREHVhV>; Tue, 8 May 2001 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135491AbREHVhL>; Tue, 8 May 2001 17:37:11 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:30925 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135404AbREHVg5>; Tue, 8 May 2001 17:36:57 -0400
Date: Tue, 8 May 2001 23:32:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <15096.23421.564537.144351@pizda.ninka.net>
Message-ID: <Pine.GSO.3.96.1010508232117.4713F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, David S. Miller wrote:

> There are several get_unmapped_area() implementations besides the
> standard one (search for HAVE_ARCH_UNMAPPED_AREA).  Please fix
> them up too.

 Yep, I know (ia64 and sparc*).  But being lazy enough (and being short on
time) I won't do it until I know the idea of the change is accepted.  I'm
sorry -- I sent previous versions of the patch twice since last Summer
with no response at all and doing bits no one is interested in is a waste
of time.

 Thanks for your response, though -- maybe there is someone interested,
after all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

