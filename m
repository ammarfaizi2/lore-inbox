Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135646AbRDXOe7>; Tue, 24 Apr 2001 10:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRDXOeu>; Tue, 24 Apr 2001 10:34:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135646AbRDXOeb>; Tue, 24 Apr 2001 10:34:31 -0400
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
To: cate@debian.org
Date: Tue, 24 Apr 2001 15:35:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), eccesys@topmail.de (mirabilos),
        cate@dplanet.ch (Giacomo A. Catenazzi),
        linux-kernel@vger.kernel.org (CML2)
In-Reply-To: <3AE588E9.2E1B1B5D@math.ethz.ch> from "Giacomo Catenazzi" at Apr 24, 2001 04:08:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s3uT-0002BY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 14    USA-18X Serial Adapter.  Distribution and/or
> Modification of the
> 15    keyspan.c driver which includes this firmware, in whole
> or in part,
> 16    requires the inclusion of this statement."
> 17 
> 18 */
> with a surelly non-free/non-GPL license.

That one is being sorted out currently. The firmware itself is fine (its mere
aggregation) but there are some problems with the firmware distribution aspects
of it.

Going through checking licensing is generally a good idea. Its something that
becomes more important over time and people become more fussy about with unclear
cases (trn, tin, getty-ps for example are probably non free apps but people
assume they are 'free software'). Older versions of glibc (2.1 etc) have 
some odd licensing bits in one area



