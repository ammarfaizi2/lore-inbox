Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJUIIo>; Mon, 21 Oct 2002 04:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJUIIo>; Mon, 21 Oct 2002 04:08:44 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:17417 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261274AbSJUIIn>; Mon, 21 Oct 2002 04:08:43 -0400
Date: Mon, 21 Oct 2002 17:14:19 +0900 (JST)
Message-Id: <20021021.171419.81047036.yoshfuji@wide.ad.jp>
To: landley@trommello.org
Cc: davem@redhat.com, rusty@rustcorp.com.au, zippel@linux-m68k.org,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, boissiere@adiglobal.com, mingo@redhat.com
Subject: Re: 2.6: Shortlist of Missing Features
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <200210202207.21397.landley@trommello.org>
References: <20021021.004328.94367521.davem@redhat.com>
	<20021021.165915.119823836.yoshfuji@wide.ad.jp>
	<200210202207.21397.landley@trommello.org>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200210202207.21397.landley@trommello.org> (at Sun, 20 Oct 2002 22:07:21 -0500), Rob Landley <landley@trommello.org> says:

> On Monday 21 October 2002 02:59, YOSHIFUJI Hideaki wrote:
> > In article <20021021.004328.94367521.davem@redhat.com> (at Mon, 21 Oct 2002 
> 00:43:28 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:
> > >    > IPSEC from Alexey and myself, and new CryptoAPI from James Morris.
> > >
> > >    URLs to which would be nice.
> > >
> > > No URLs, being coded as I type this :-)
> > >
> > > Some of the ipv4 infrastructure is in 2.5.44
> >
> > How about IPv6?  We need it. :-)
> 
> At this point, we need a URL to a specific patch.  (Ideas aren't going to be 
> submitted to Linus by this time next week, code is.  Preferably tested 
> code...)

Well, our IPsec is ready, runs and is tested...
 <ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/>

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
