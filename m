Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCZVly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCZVly (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVCZVlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:41:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19169 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261303AbVCZVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:41:46 -0500
Date: Sat, 26 Mar 2005 21:41:41 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk
Subject: Re: [ARM] Group device drivers together under their own menu
Message-ID: <20050326214141.GR21986@parcelfarce.linux.theplanet.co.uk>
References: <200503261912.j2QJC192031517@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503261912.j2QJC192031517@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 11:58:51AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1982.137.48, 2005/03/05 11:58:51+00:00, rmk@flint.arm.linux.org.uk
> 
> 	[ARM] Group device drivers together under their own menu

Any reason you can't merge ARM's options into the drivers/*/Kconfig (with
appropriate conditionals) and use drivers/Kconfig?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
