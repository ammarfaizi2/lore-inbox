Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVCOARp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVCOARp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCOAQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:16:04 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:39142
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S262150AbVCOAPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:15:07 -0500
Date: Tue, 15 Mar 2005 00:14:45 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: dwmw2@infradead.org, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: use unsigned 1-bit fields
Message-ID: <20050315001445.GB6903@home.fluff.org>
References: <20050314160701.494a50d8.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314160701.494a50d8.rddunlap@osdl.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 04:07:01PM -0800, Randy.Dunlap wrote:
> (resend)
> 
> Fix (22) bitfield/boolean sparse warnings:
> include/linux/mtd/flashchip.h:65:23: warning: dubious one-bit signed bitfield
> include/linux/mtd/flashchip.h:66:23: warning: dubious one-bit signed bitfield

caught in the mtd-cvs, so it depends if you want to
wait for the next mtd merge or not.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
