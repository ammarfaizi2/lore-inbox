Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUF3He2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUF3He2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUF3He2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:34:28 -0400
Received: from holomorphy.com ([207.189.100.168]:7598 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266578AbUF3He1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:34:27 -0400
Date: Wed, 30 Jun 2004 00:34:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bryce Harrington <bryce@osdl.org>
Cc: ltp-list@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes in LTP test results
Message-ID: <20040630073419.GH21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bryce Harrington <bryce@osdl.org>, ltp-list@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0406281833380.13977-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0406281833380.13977-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 06:46:15PM -0700, Bryce Harrington wrote:
> We usually always see 6-7 fails on the 2.6.x kernels, so the increase is
> unusual.
> I've generated some detailed LTP test result reports on a few of the
> above runs, with specifics about the test runs and failures.  These are
> available here:
>     http://developer.osdl.org/bryce/ltp/

This looks related to some widely-propagated change in errno return
value (probably originating from some centralized source and cascading
up the call chains).


-- wli
