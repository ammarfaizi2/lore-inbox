Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUF0Ay5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUF0Ay5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 20:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUF0Ay5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 20:54:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3498 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266532AbUF0Ay4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 20:54:56 -0400
Date: Sun, 27 Jun 2004 01:54:55 +0100
From: Matthew Wilcox <willy@debian.org>
To: Roland Dreier <roland@topspin.com>
Cc: Matthew Wilcox <willy@debian.org>, mj@ucw.cz,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
Message-ID: <20040627005455.GA30334@parcelfarce.linux.theplanet.co.uk>
References: <52y8mayzdy.fsf@topspin.com> <20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk> <52r7s1zyn1.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52r7s1zyn1.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 04:29:38PM -0700, Roland Dreier wrote:
>     Matthew> Martin, how can we make this easiest for you?  Do you
>     Matthew> want to merge Roland's fully-fledged MSI-X patch and put
>     Matthew> out a new -test release that I can send half-baked PCI-E
>     Matthew> patches against until everybody's happy with the outcome?
> 
> Ahh... I'll hold off on writing my PCI-e capability parser then :)

Did you not see the one I posted to linux-pci yesterday?  As I say,
it's only half-done.  I wanted to get a feel for whether people like
the direction I'm taking.

Unfortunately, I can't see a web archive of linux-pci anywhere -- even
on MArc.  I can forward the patches though.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
