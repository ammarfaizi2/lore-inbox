Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbUDGIDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbUDGIDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:03:36 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9487 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264136AbUDGIDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:03:34 -0400
Date: Wed, 7 Apr 2004 18:03:22 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Subject: Unused files in sound/oss
Message-ID: <20040407080322.GA531@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please remove the files 724hwmcode.h and Hwmcode.h from
sound/oss in 2.6 and drivers/sound in 2.2/2.4.

The're not used anywhere and appear to be illegal for anyone
to distribute.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
