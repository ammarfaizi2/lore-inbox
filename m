Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUCHGDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUCHGDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:03:02 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:28179 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262402AbUCHGCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:02:38 -0500
Date: Mon, 08 Mar 2004 15:04:02 +0900 (JST)
Message-Id: <20040308.150402.86498894.yoshfuji@linux-ipv6.org>
To: marcelo.tosatti@cyclades.com
Cc: bunk@fs.tum.de, degger@fhm.edu, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
References: <20040307155008.GM22479@fs.tum.de>
	<Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
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

In article <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades> (at Mon, 8 Mar 2004 02:22:36 -0300 (BRT)), Marcelo Tosatti <marcelo.tosatti@cyclades.com> says:

> > -LANMEDIA WAN CARD DRIVER
> > -P:      Andrew Stanley-Jones
> > -M:      asj@lanmedia.com
> > -W:      http://www.lanmedia.com/
> > -S:      Supported
> > - 
> >  LAPB module
> >  P:	Henner Eisen
> >  M:	eis@baty.hanse.de
> > 
> 
> I think it might be better to change to
> 
> 
> LANMEDIA WAN CARD DRIVER
> S: UNMAINTAINED
> 
> Thoughts? 

"S" is one of the following (from MAINTAINERS):

        Supported:      Someone is actually paid to look after this.
        Maintained:     Someone actually looks after it.
        Odd Fixes:      It has a maintainer but they don't have time to do
                        much other than throw the odd patch in. See below..
        Orphan:         No current maintainer [but maybe you could take the
                        role as you write your new code].
        Obsolete:       Old code. Something tagged obsolete generally means
                        it has been replaced by a better system and you
                        should be using that.

--yoshfuji
