Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275928AbTHOMcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275929AbTHOMcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:32:08 -0400
Received: from blackhole.kfki.hu ([148.6.0.114]:42758 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S275928AbTHOMcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:32:06 -0400
Date: Fri, 15 Aug 2003 14:32:04 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmem_cache_destroy: Can't free all objects (2.6)
In-Reply-To: <3F3CE8BF.6080800@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0308151426360.9501-100000@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Philippe Elie wrote:

> Thanks, I wanted to be sure before digging in the source. Try
> the attached patch please.

Thank you, the patched kernel is up and the tests are started.
I'll report you the results.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary

