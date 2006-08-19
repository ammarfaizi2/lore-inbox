Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWHSA60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWHSA60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWHSA60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:58:26 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:36102 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S1422667AbWHSA6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:58:25 -0400
Date: Sat, 19 Aug 2006 02:58:15 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
Message-ID: <20060819005815.GR16542@vanheusden.com>
References: <44E096B4.9090207@xs4all.nl>
	<20060814.130814.126764626.davem@davemloft.net>
	<44E139CD.3080103@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E139CD.3080103@xs4all.nl>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Wed Aug 16 21:02:09 CEST 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Udo van den Heuvel <udovdh@xs4all.nl>
> > Date: Mon, 14 Aug 2006 17:28:52 +0200
> >> Since 2.6.17.x my kernel Oopses every few days. Bewlo is the log.
> > Contact whoever you got this "pptp_gre.c" source file from.
> > It's not in the vanilla kernel, therefore we can't help you
> > debug the problem.
> pptpd is needed for my adsl connection.
> pppd runs over it.
> it is not part of the kernel.

Nope, you don't need it. Plain vanilla kernel will work fine with the
pptp connection to your adsl modem (got the same situation over here).


Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
