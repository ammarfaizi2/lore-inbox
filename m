Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWGLAFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWGLAFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWGLAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:05:20 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:37577 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932281AbWGLAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:05:19 -0400
Date: Wed, 12 Jul 2006 01:04:56 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net,
       linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
Message-ID: <20060712000456.GA6002@srcf.ucam.org>
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711171238.GA26186@tuxdriver.com> <200607111909.22972.s0348365@sms.ed.ac.uk> <44B3ED29.4040801@gmail.com> <1152644119.18028.46.camel@localhost.localdomain> <20060711222202.GA5064@srcf.ucam.org> <44B43A30.1040006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B43A30.1040006@zytor.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 04:54:24PM -0700, H. Peter Anvin wrote:
> Matthew Garrett wrote:
> >The ipw3945_daemon.h file includes a pretty full description of what the 
> >daemon has to do, and all the structures have nice friendly names. 
> >There's also a changelog of the protocol. It shouldn't take someone 
> >long.
> >
> 
> It's already been done, too.

For Linux, too? The OpenBSD approach seems to have been to integrate it 
into the driver, which is fine for them but would probably make it more 
awkward for us to keep things synced with the Intel code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
