Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292868AbSBVOGN>; Fri, 22 Feb 2002 09:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292867AbSBVOGD>; Fri, 22 Feb 2002 09:06:03 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:9203 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S292868AbSBVOFt>; Fri, 22 Feb 2002 09:05:49 -0500
Date: Fri, 22 Feb 2002 15:04:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dan Kegel <dank@kegel.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        zab@zabbo.net
Subject: Re: is CONFIG_PACKET_MMAP always a win?
In-Reply-To: <3C75ED64.28CCFA6B@kegel.com>
Message-ID: <Pine.GSO.3.96.1020222145834.5266D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Dan Kegel wrote:

> The important files are a bit buried.  The important ones seem to be
> 
> ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/README
> ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/libpcap-0.4-ss991029.dif.gz
> ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/libpcap-0.4.tar.gz
> 
> The .dif file contains the first example I've seen of
> how to use socket option PACKET_RX_RING.

 Too bad the changes did not get integrated -- libpcap 0.7.1 doesn't know
anything about PACKET_RX_RING... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

