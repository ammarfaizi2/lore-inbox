Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269669AbUICRbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbUICRbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269611AbUICRaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:30:20 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:39119 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269680AbUICRZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:25:17 -0400
Date: Fri, 03 Sep 2004 13:24:28 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH/RFC 2.6] NET: 64-bit network statistics
In-reply-to: <200409031307.01240.jeffpc@optonline.net>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Message-id: <200409031324.36252.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200409031307.01240.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 03 September 2004 13:06, josef Jeff Sipek wrote:
> I've created a patch that monitors changes to the network statistics
> variables and keeps internal 64-bit counter. I decided to split it into two
> parts (patches are to follow in next emails):
>  1) generic variable monitoring system (watch64)
>  2) network statistics specific patch (64network)

Btw, both of these patches apply cleanly against 2.6.9-rc1-bk10.

Jeff.

- -- 
bad pun of the week: the formula 1 control computer suffered from a race 
condition
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOKjQwFP0+seVj/4RApg/AKDEFSTVOMSvVh9zVU65o/P6ZcfBxgCffeId
QddOVsR+uHdkV2D4/U8QVO4=
=jQIT
-----END PGP SIGNATURE-----
