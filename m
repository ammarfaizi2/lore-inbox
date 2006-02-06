Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWBFWuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWBFWuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWBFWuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:50:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39912 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932407AbWBFWuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:50:04 -0500
Subject: Re: [PATCH] Revert serial 8250 console fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <812D6543-5268-4D3E-93B0-12161D148120@kernel.crashing.org>
References: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org>
	 <1139250251.10437.39.camel@localhost.localdomain>
	 <DC17879A-2B03-4D20-865F-C89386A393EF@kernel.crashing.org>
	 <1139254711.10437.42.camel@localhost.localdomain>
	 <812D6543-5268-4D3E-93B0-12161D148120@kernel.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 22:51:54 +0000
Message-Id: <1139266314.10437.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 14:56 -0600, Kumar Gala wrote:
> The following seems to make things better for me.  Can you take a  
> look and let me know what you thing.  If it looks good, I'll send  
> Russell a clean patch:

That looks sensible. 

