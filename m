Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWAAUuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAAUuD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 15:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWAAUuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 15:50:02 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:18664 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932254AbWAAUuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 15:50:00 -0500
Date: Sun, 1 Jan 2006 21:49:58 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mark v Wolher <trilight@ns666.com>
Cc: Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20060101204958.GG27444@vanheusden.com>
References: <20051231163414.GE3214@m.safari.iki.fi>
	<20051231163414.GE3214@m.safari.iki.fi>
	<43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com>
	<43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com>
	<43B7EB99.8010604@ns666.com>
	<20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
	<20060101184916.GE27444@vanheusden.com>
	<43B8256C.2060407@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B8256C.2060407@ns666.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jan  2 17:36:49 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just to add:
> > something else is fishy: when I start iptraf (or some other traffic
> > dumper) my system hangs up. repeatable. also with a bttv card which is
> > occasionally used for grabbing videotext pages
> 
> That could be an irq sharing issue i think.

Nope.

> Do you use also grabdisplay instead of overlay mode?

No, I grab videotext pages.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
