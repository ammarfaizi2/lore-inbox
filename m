Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWCaJy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWCaJy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCaJy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:54:56 -0500
Received: from smop.co.uk ([81.5.177.201]:11499 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1751285AbWCaJyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:54:55 -0500
Date: Fri, 31 Mar 2006 10:54:43 +0100
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
Message-ID: <20060331095443.GA8616@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, ak@muc.de,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060330.152821.24959319.davem@davemloft.net> <20060331012235.GB45568@muc.de> <20060331072859.GA5389@smop.co.uk> <20060330.234823.109651253.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330.234823.109651253.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.662,
	required 5, autolearn=not spam, AWL -0.06, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 23:48:23 -0800 (-0800), David S. Miller wrote:
> As I stated, there was a bug in the initial patch, which subsequent
> patches fix.
> 
> Can you try Linus's current tree to see if the problem is there?

2-6-16-git18 still has the problem (30th March).

Adrian
