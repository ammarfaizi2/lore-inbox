Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUCHJLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUCHJK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:10:59 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:30995 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262423AbUCHJKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:10:55 -0500
Date: Mon, 08 Mar 2004 18:12:20 +0900 (JST)
Message-Id: <20040308.181220.131486671.yoshfuji@linux-ipv6.org>
To: mulix@mulix.org
Cc: marcelo.tosatti@cyclades.com, bunk@fs.tum.de, degger@fhm.edu,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040308071642.GL877@mulix.org>
References: <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
	<20040308.150402.86498894.yoshfuji@linux-ipv6.org>
	<20040308071642.GL877@mulix.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040308071642.GL877@mulix.org> (at Mon, 8 Mar 2004 09:16:43 +0200), Muli Ben-Yehuda <mulix@mulix.org> says:

> > > LANMEDIA WAN CARD DRIVER
> > > S: UNMAINTAINED
:

> > "S" is one of the following (from MAINTAINERS):
> > 
> >         Supported:      Someone is actually paid to look after this.
> 
> Then we should add 'unmaintained'... something like this: 
:
>  			should be using that.
> +        Unmaintained:	Nobody is taking care of it. Maybe you want to?
>  
:

Well, I think "Orphan" is what this entry needs.

--yoshfuji
