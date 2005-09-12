Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVILHtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVILHtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVILHtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:49:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:44954 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1751204AbVILHtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:49:20 -0400
Date: Mon, 12 Sep 2005 00:49:14 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jan Beulich <JBeulich@novell.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 CFI annotations
Message-ID: <20050912074914.GA31047@twiddle.net>
Mail-Followup-To: Jan Beulich <JBeulich@novell.com>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
References: <432070850200007800024465@emea1-mh.id2.novell.com> <20050908154645.GN3966@smtp.west.cox.net> <43207BA30200007800024502@emea1-mh.id2.novell.com> <20050908161334.GP3966@smtp.west.cox.net> <43214D2D02000078000247B5@emea1-mh.id2.novell.com> <20050910055836.GA28662@twiddle.net> <4325448C0200007800024DF5@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325448C0200007800024DF5@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:04:12AM +0200, Jan Beulich wrote:
> But truly I think the processor-specific pieces of Dwarf's
> frame unwind spec should provide numbering for the complete set of
> registers.

Except there is no standards body for this.  So *someone* will
have to make it up.

Make it up and put it in gas and gdb: that will make it a defacto standard.


r~
