Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbSI2QMX>; Sun, 29 Sep 2002 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSI2QMX>; Sun, 29 Sep 2002 12:12:23 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:19443 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262791AbSI2QMW>; Sun, 29 Sep 2002 12:12:22 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020929152652.GF29737@merlin.emma.line.org>
References: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain>
	<Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> 
	<20020929152652.GF29737@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 17:24:07 +0100
Message-Id: <1033316647.13001.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 16:26, Matthias Andree wrote:
> I personally have the feeling that 2.2.x performed better than 2.4.x
> does, but I cannot go figure because I'm using ReiserFS 3.6 file

On low end boxes the benchmarks I did show later 2.4-rmap beats 2.2. 2.0
worked suprisingly well (better than pre-rmap 2.4) and as Stephen
claimed the best code was about 2.1.100, 2.2 then dropped badly from
that point.

Low memory is of course where rmap does best, so the 2.4-rmap v 2.4
parts of such testing are not actually that useful


