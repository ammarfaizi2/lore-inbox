Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJCDZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJCDZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVJCDZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 23:25:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932133AbVJCDZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 23:25:16 -0400
Date: Sun, 2 Oct 2005 23:25:12 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: <200510030255.j932toIK012248@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.63.0510022324370.27456@cuia.boston.redhat.com>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
            <20051003005400.GM6290@lkcl.net> <200510030255.j932toIK012248@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Valdis.Kletnieks@vt.edu wrote:

> OK.. I'll bite.  How do you find the 5th or 6th entry in the linked 
> list, when only the first entry is in cache, in a single cycle, when a 
> cache line miss is more than a single cycle penalty, and you have 
> several "These are not the droids you're looking for" checks and go on 
> to the next entry - and do it in one clock cycle?

A nice saying from the last decade comes to mind:

"If you can do all that in one cycle, your cycles are too long."

-- 
All Rights Reversed
