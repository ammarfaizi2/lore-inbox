Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUI3XEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUI3XEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269606AbUI3XEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:04:00 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:26752 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S269603AbUI3XD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:03:56 -0400
Date: Fri, 1 Oct 2004 09:03:53 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20040930230353.GA7162@zip.com.au>
References: <20040927084550.GA1134@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927084550.GA1134@zip.com.au>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 06:45:51PM +1000, CaT wrote:
> I have a Promise PDC20267 card in my desktop and whilst it works
> in 2.6.8-rc2, it no longer functions beginning with at least 2.6.9-rc2.
> Latest kernel I ran is 2.6.9-rc2-bk8 and it was still not available.
> 
> dmesg does mention it though as:
> 
> PDC20267: IDE controller at PCI slot 0000:00:0d.0
> PCI: Found IRQ 11 for device 0000:00:0d.0
> PCI: Unable to reserve I/O region #5:40@1080 for device 0000:00:0d.0
> 
> And that's as far as it gets.

Just tried it with rc3. Same deal. I can only access half my drives. :/

Any debugging that needs doing that I can do to help resolve this?

-- 
    Red herrings strewn hither and yon.
