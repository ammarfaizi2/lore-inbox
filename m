Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVAMR7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVAMR7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVAMR5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:57:09 -0500
Received: from mail.enyo.de ([212.9.189.167]:11409 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261247AbVAMRxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:53:01 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net>
	<Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112161227.GF32024@logos.cnet>
	<Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	<20050112174203.GA691@logos.cnet>
	<1105627541.4624.24.camel@localhost.localdomain>
Date: Thu, 13 Jan 2005 18:52:56 +0100
In-Reply-To: <1105627541.4624.24.camel@localhost.localdomain> (Alan Cox's
	message of "Thu, 13 Jan 2005 15:36:27 +0000")
Message-ID: <87vfa1gqrr.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox:

> We cannot do this without the reporters permission. Often we get
> material that even the list isn't allowed to directly see only by
> contacting the relevant bodies directly as well. The list then just
> serves as a "foo should have told you about issue X" notification.
>
> If you are setting up the list also make sure its entirely encrypted
> after the previous sniffing incident.

Others have had made good use of symmetric encryption with OpenPGP
(the CAST5 cipher seems most interoperable).  New symmetric keys are
distributed twice per year, using the participants OpenPGP public
keys.

(There are also various implementations of reencrypting mailing lists,
but they cannot ensure end-to-end encryption.)
