Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272948AbTHPOUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272945AbTHPOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:20:37 -0400
Received: from blackhole.kfki.hu ([148.6.0.114]:49926 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S272948AbTHPOUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:20:32 -0400
Date: Sat, 16 Aug 2003 16:20:28 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmem_cache_destroy: Can't free all objects (2.6)
In-Reply-To: <Pine.LNX.4.33.0308151426360.9501-100000@blackhole.kfki.hu>
Message-ID: <Pine.LNX.4.33.0308161619100.12005-100000@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Jozsef Kadlecsik wrote:

> > Thanks, I wanted to be sure before digging in the source. Try
> > the attached patch please.
>
> I'll report you the results.

With your patch applied, the problem went away!
Thank you very much indeed!

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary

