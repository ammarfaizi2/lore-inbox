Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752221AbWAEVnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbWAEVnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbWAEVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:43:32 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:9355 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1752220AbWAEVnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:43:31 -0500
Date: Thu, 5 Jan 2006 22:43:29 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.13.3] occasional oops mostly in iget_locked
Message-ID: <20060105214329.GE10923@vanheusden.com>
References: <20051219190137.GA13923@vanheusden.com>
	<3888a5cd0601050849p6ee4cb48s9cc9c9bd6fd20cc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3888a5cd0601050849p6ee4cb48s9cc9c9bd6fd20cc8@mail.gmail.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Jan  6 19:20:40 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1. occasional oops with 2.6.13.3
> > 2. see 1
> > 3. fs
> > 4. 2.6.13.3
> > 5. 2.6.11.6 (none tested inbetween)
> and what about later kernel?
> Could you try git bisect (or manual) to determine the exactly frist
> "bad" version as accurate as possible?

Well that problem seems to be solved in 2.6.15 so does this problem
matter anymore? I'm a little hesitant to play a lot with that system as
it'll make some people really upset.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
