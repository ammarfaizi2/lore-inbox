Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVCXMh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVCXMh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVCXMh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:37:29 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:12714 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262806AbVCXMhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:37:22 -0500
Date: Thu, 24 Mar 2005 13:37:21 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, michal@logix.cz
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324123719.GY29897@vanheusden.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast> <42424C6D.2020605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42424C6D.2020605@pobox.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Wed Mar 23 21:52:36 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, there are other entropy daemons floating about.  I think there is 
> one that obtains noise from an audio device.

That's correct: http://www.vanheusden.com/aed/ audio-entropyd

There's also one for doing the same with video4linux devices: 
http://www.vanheusden.com/ved/


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!
