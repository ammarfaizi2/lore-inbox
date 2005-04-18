Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVDRIpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVDRIpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDRIpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:45:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:40124 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261944AbVDRIpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:45:44 -0400
Date: Mon, 18 Apr 2005 10:45:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Morris <jmorris@redhat.com>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [RFC][PATCH 0/4] AES assembler implementation for x86_64
Message-ID: <20050418084527.GA19572@wohnheim.fh-wedel.de>
References: <4262B6D4.30805@domdv.de> <Xine.LNX.4.44.0504180349200.10998-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Xine.LNX.4.44.0504180349200.10998-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 April 2005 03:50:32 -0400, James Morris wrote:
>
> Please cc Herbert Xu on kernel crypto patches, he's the frontline 
> maintainer of it now.

Care to sign off this patch (or create a similar one)?

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11cow/MAINTAINERS~crypto_maintainer	2005-03-04 11:39:53.000000000 +0100
+++ linux-2.6.11cow/MAINTAINERS	2005-04-18 10:43:40.963766936 +0200
@@ -596,8 +596,8 @@ W:	http://developer.axis.com
 S:	Maintained
 
 CRYPTO API
-P:	James Morris
-M:	jmorris@redhat.com
+P:	Herbert Xu
+M:	herbert@gondor.apana.org.au
 P:	David S. Miller
 M:	davem@davemloft.net
 W	http://samba.org/~jamesm/crypto/
