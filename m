Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTKFPIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTKFPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:08:21 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:28329 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S263637AbTKFPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:08:18 -0500
Date: Thu, 6 Nov 2003 16:08:00 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mii broken for 3c59x ?
In-Reply-To: <3FAA4EF9.70704@pobox.com>
Message-ID: <Pine.LNX.4.51.0311061606560.715@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
 <3FAA4EF9.70704@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most likely you need to recompile mii-tool, because it's using old ioctls.
It's from debian packages. I'll get the sources, compile, and see if it
works.

Also, mii-diag works fine. So the above is just a test.


> 	Jeff
Maciej

