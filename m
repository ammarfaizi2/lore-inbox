Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUEKJD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUEKJD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEKJDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:03:23 -0400
Received: from styx.suse.cz ([82.208.2.94]:8070 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S262768AbUEKJAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:00:19 -0400
Date: Tue, 11 May 2004 11:01:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] New set of input patches
Message-ID: <20040511090102.GA28867@ucw.cz>
References: <200405110124.14948.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405110124.14948.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 01:24:14AM -0500, Dmitry Torokhov wrote:
> Hi Vojtech,
> 
> I have some more input patches. Nothing too intresting, most of the important
> stuff has been posted on LKML before. Here they are:

All look good. Thanks!

> I did merge with Linus' tree to resolve conflicts with Eric's latest
> changes to logips2pp (hope he does not mind). Please do:
> bk pull bk://dtor.bkbits.net/input

That's very nice. So the MX700 support is still in? (Well, I'll pull and
see).

> The following patches are against your tree rather then Linis' and I will
> not post whitespace fixing patches as they are too boring...
> 
> There is also a cumulative patch agains Linus' tree at:
> http://www.geocities.com/dt_or/input/2_6_6/input-cumulative.patch.gz

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
