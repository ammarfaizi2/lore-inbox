Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTESXhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTESXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:37:15 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:3080 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261287AbTESXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:37:14 -0400
Date: Tue, 20 May 2003 01:50:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, jamagallon@able.es, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com, cs@tequila.co.jp
Subject: Re: [PATCH] Documentation for iostats
Message-ID: <20030519235000.GB533@win.tue.nl>
References: <200305192118.h4JLIu710201@owlet.beaverton.ibm.com> <20030519154858.3b3e2677.akpm@digeo.com> <20030519225542.GE6096@werewolf.able.es> <20030519160133.58385b88.akpm@digeo.com> <20030519163816.66489368.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519163816.66489368.rddunlap@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 04:38:16PM -0700, Randy.Dunlap wrote:

> There are 3 widely-used date formats, but only one standard one.
> 
> 05/15/2003  (US et al order; the worst of the 3 IMO :)
> 15/05/2003  (or your 15 May 2003)
> 2003/05/15  (ISO standard)

ISO 8601 suggests 2003-05-15 as main date notation.
(Then there are all kinds of abbreviations.)
Avoid slashes.

