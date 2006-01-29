Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWA2WF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWA2WF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWA2WF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:05:29 -0500
Received: from pat.uio.no ([129.240.130.16]:44505 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751193AbWA2WF2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:05:28 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060129220217.GA21832@hardeman.nu>
References: <20060127204158.GA4754@hardeman.nu>
	 <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
	 <1138552702.8711.12.camel@lade.trondhjem.org>
	 <20060129211310.GA20118@hardeman.nu>
	 <1138570100.8711.63.camel@lade.trondhjem.org>
	 <20060129220217.GA21832@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sun, 29 Jan 2006 17:05:11 -0500
Message-Id: <1138572311.8711.84.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.668, required 12,
	autolearn=disabled, AWL 1.15, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 23:02 +0100, David Härdeman wrote:
> On Sun, Jan 29, 2006 at 04:28:20PM -0500, Trond Myklebust wrote:
> >On Sun, 2006-01-29 at 22:13 +0100, David Härdeman wrote:
> >> How do you use a "time-limited proxy in the daemon" for your own 
> >> keys/cerificates (e.g. ssh keys)?
> >
> >I don't have to. Why are you apparently insisting on this weird fallacy
> >that a keyring can only hold one certificate at a time?
> 
> I'm talking about ssh keys, not kerberos tickets.

As I said previously, the lack of support for proxies would appear to be
a bug in ssh, not the kernel.

Cheers,
  Trond

