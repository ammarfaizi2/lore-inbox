Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUKKQKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUKKQKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbUKKQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:10:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262267AbUKKQIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:08:43 -0500
Date: Thu, 11 Nov 2004 16:08:42 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Len Brown <len.brown@intel.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: #ifdef unused functions away
Message-ID: <20041111160842.GD1108@parcelfarce.linux.theplanet.co.uk>
References: <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe> <20041110012134.GB4089@stusta.de> <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk> <20041111153650.GD8417@stusta.de> <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk> <20041111154656.GE8417@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111154656.GE8417@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 04:46:56PM +0100, Adrian Bunk wrote:
> I didn't saw your patch on linux-kernel

I didn't send it to linux-kernel; only acpi-devel and linux-ia64.

> Did Len already integrate your driver into his tree?

No, I just sent him a reminder today.

> If yes, I will correct the acpi_remove_gpe_block case (it's only this 
> one function?) as soon as his tree appears in the next -mm.

acpi_remove_gpe_block and acpi_install_gpe_block.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
