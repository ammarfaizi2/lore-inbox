Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCUSRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCUSRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCUSRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:17:22 -0500
Received: from are.twiddle.net ([64.81.246.98]:47747 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261426AbVCUSRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:17:19 -0500
Date: Mon, 21 Mar 2005 10:16:18 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050321181618.GA7136@twiddle.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
	Leendert van Doorn <leendert@watson.ibm.com>,
	Reiner Sailer <sailer@watson.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net> <1111416728.14833.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111416728.14833.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 02:52:10PM +0000, Alan Cox wrote:
> The issue is bigger - it's needed for the CMD controllers on PA-RISC for
> example it appears - and anything else where IDE legacy IRQ is wired
> oddly.

Sure, but who queries this information?  That's my question.


r~
