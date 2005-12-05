Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVLEVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVLEVAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVLEVAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:00:33 -0500
Received: from mail.enyo.de ([212.9.189.167]:43243 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751397AbVLEVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:00:32 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<1133620264.2171.14.camel@localhost.localdomain>
	<20051203193538.GM31395@stusta.de>
	<1133639835.16836.24.camel@mindpipe>
	<20051203225815.GH25722@merlin.emma.line.org>
Date: Mon, 05 Dec 2005 22:00:30 +0100
In-Reply-To: <20051203225815.GH25722@merlin.emma.line.org> (Matthias Andree's
	message of "Sat, 3 Dec 2005 23:58:15 +0100")
Message-ID: <87y82z5kep.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Andree:

> The point that just escaped you as the motivation for this thread was
> the availability of security (or other critical) fixes for older
> kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
> available for those who find 2.6.8 works for them (the fix went into
> 2.6.14 BTW), and the concern is the development model isn't fit to
> accomodate needs like this.

Well, if there's a CVE name, the proper patch isn't *that* far away
(someone has already done a bit of work to isolate the fix).  The real
issue seems to be how to make sure that CVE names are assigned during
the kernel development process (and not just as an afterthought by the
security folks).
