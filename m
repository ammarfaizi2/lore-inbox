Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTK0MJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTK0MJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:09:50 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:58630 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264492AbTK0MJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:09:49 -0500
Date: Thu, 27 Nov 2003 21:09:53 +0900 (JST)
Message-Id: <20031127.210953.116254624.yoshfuji@linux-ipv6.org>
To: felipe_alfaro@linuxmail.org
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1069934643.2393.0.camel@teapot.felipe-alfaro.com>
References: <20031127.173320.19253188.yoshfuji@linux-ipv6.org>
	<20031127025921.3fed8dd4.davem@redhat.com>
	<1069934643.2393.0.camel@teapot.felipe-alfaro.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1069934643.2393.0.camel@teapot.felipe-alfaro.com> (at Thu, 27 Nov 2003 13:04:04 +0100), Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> says:

> On Thu, 2003-11-27 at 11:59, David S. Miller wrote:
> 
> > I agree, using sizeof() is the less error prone way of
> > doing things like this.
> > 
> > Felipe could you please rewrite your patch like this?
> 
> Done!

Thanks. Ok to me.
--yoshfuji
