Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUIRGO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUIRGO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 02:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUIRGO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 02:14:27 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:17831 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S269140AbUIRGO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 02:14:26 -0400
Date: Sat, 18 Sep 2004 08:13:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Via-Rhine WOL vs PXE Boot
Message-ID: <20040918061331.GA12757@k3.hellgate.ch>
Mail-Followup-To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>,
	linux-kernel@vger.kernel.org
References: <200409172154.36550.lists@kenneth.aafloy.net> <20040917203458.GA12779@k3.hellgate.ch> <200409180001.42332.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409180001.42332.lists@kenneth.aafloy.net>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 00:01:42 +0200, Kenneth Aafløy wrote:
> Or should this rather be reported as a bug to Via, so that they can implement 
> restoring the adapter from the D3 state in the pxe boot rom?

Have you tried the VIA driver to check if it fares any better?

> I've attached what I belive to be a bk patch (kinda new to that) which 
> comments out this power-state change, untill something better is found. I 
> have not tested WOL with this, but I can't think of any reason why it should 
> not work.

I'm afraid you will convince neither me nor the hardware with assumptions.

Roger
