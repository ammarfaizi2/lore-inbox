Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUJ1PYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUJ1PYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUJ1PW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:22:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261714AbUJ1PNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:13:42 -0400
Date: Thu, 28 Oct 2004 16:13:36 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: james4765@verizon.net
Cc: kernel-janitors@lists.osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 7/9] to arch/sparc/Kconfig
Message-ID: <20041028151336.GA10769@parcelfarce.linux.theplanet.co.uk>
References: <20041028150029.2776.69333.50087@localhost.localdomain> <20041028150111.2776.47585.86377@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028150111.2776.47585.86377@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:01:12AM -0500, james4765@verizon.net wrote:
> Description: Add default for SUN4 in arch/sparc/Kconfig.
> Apply against 2.6.9.

The default is already "no".  This patch seems pointless.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
