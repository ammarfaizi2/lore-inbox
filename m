Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGASNV>; Mon, 1 Jul 2002 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316080AbSGASNU>; Mon, 1 Jul 2002 14:13:20 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28330
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316070AbSGASNT>; Mon, 1 Jul 2002 14:13:19 -0400
Date: Mon, 1 Jul 2002 11:12:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020701181228.GF20920@opus.bloom.county>
References: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:

> What's the issue?

a) We're at 2.4.19-rc1 right now.  It would be horribly
counterproductive to put O(1) in right now.
b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
to 2.4, it'd be just like 2.5 :)
c) I also suspect that it hasn't been as widley tested on !x86 as the
stuff currently in 2.4.  And again, 2.4 is the stable tree.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
