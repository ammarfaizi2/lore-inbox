Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJSVFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJSVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:05:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51462 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262225AbTJSVFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:05:15 -0400
Date: Sun, 19 Oct 2003 23:04:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org, rob@landley.net
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031019210453.GE16761@alpha.home.local>
References: <200310180018.21818.rob@landley.net> <1066477155.5606.34.camel@sonja> <3F91E01C.4090507@cyberone.com.au> <200310191245.55961.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310191245.55961.mbuesch@freenet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 12:45:46PM +0200, Michael Buesch wrote:
 
> What about making it configurable? If someone want's bzip2
> and if he want's to wait longer to boot, (s)he may
> compile bzip2 support.
> If someone dislikes it, (s)he may use gzip.

I don't know if people have already tested LZO and NRV (used in UPX). Perhaps
LZO might already be a little better than gzip, while faster and with less
code. NRV is surely better, but is not open source IIRC. Perhaps Markus would
agree to release a free NRV decompressor if asked kindly ?

Regards,
Willy

