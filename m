Return-Path: <linux-kernel-owner+w=401wt.eu-S932289AbXAPCFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXAPCFx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXAPCFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:05:51 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:46184 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbXAPCFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:05:30 -0500
Date: Tue, 16 Jan 2007 11:06:30 +0900 (JST)
Message-Id: <20070116.110630.60620489.yoshfuji@linux-ipv6.org>
To: nix.or.die@googlemail.com, greg@kroah.com, stable@kernel.org
Cc: davem@davemloft.net, dlstevens@us.ibm.com, dsd@gentoo.org,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [stable] 2.6.19.2 regression introduced by "IPV4/IPV6: Fix
 inet{, 6} device initialization order."
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <45AC3214.4080800@googlemail.com>
References: <20070114.213008.74745274.davem@davemloft.net>
	<20070115072554.GA16969@kroah.com>
	<45AC3214.4080800@googlemail.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <45AC3214.4080800@googlemail.com> (at Tue, 16 Jan 2007 03:01:56 +0100), Gabriel C <nix.or.die@googlemail.com> says:

> Greg KH schrieb:
> > On Sun, Jan 14, 2007 at 09:30:08PM -0800, David Miller wrote:
> >   
> >> From: David Stevens <dlstevens@us.ibm.com>
> >> Date: Sun, 14 Jan 2007 19:47:49 -0800
> >>
> >>     
> >>> I think it's better to add the fix than withdraw this patch, since
> >>> the original bug is a crash.
> >>>       
> >> I completely agree.
> >>     
> >
> > Great, can someone forward the patch to us?
> >   
> 
> Should be the fix from http://bugzilla.kernel.org/show_bug.cgi?id=7817

I've resent the patch to <stable@kernel.org>.

--yoshfuji
