Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUA0QO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUA0QO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:14:59 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:16913 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265056AbUA0QO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:14:58 -0500
Date: Wed, 28 Jan 2004 01:15:37 +0900 (JST)
Message-Id: <20040128.011537.81631272.yoshfuji@linux-ipv6.org>
To: rmps@joel.ist.utl.pt
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: RFC: Trailing blanks in source files
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt>
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt>
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

In article <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt> (at Tue, 27 Jan 2004 15:44:56 +0000 (WET)), Rui Saraiva <rmps@joel.ist.utl.pt> says:

> 	It seems that many files [1] in the Linux source have lines with
> trailing blank (space and tab) characters and some even have formfeed
> characters. Obviously these blank characters aren't necessary.

I do not like to change this if it is done blindly.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
