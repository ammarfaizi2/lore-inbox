Return-Path: <linux-kernel-owner+w=401wt.eu-S932800AbWLNPSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWLNPSr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLNPSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:18:47 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:54668 "EHLO
	alpha.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbWLNPSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:18:46 -0500
X-Greylist: delayed 1971 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 10:18:46 EST
Date: Thu, 14 Dec 2006 15:45:26 +0100
To: Tejun Heo <htejun@gmail.com>
Cc: avl@logic.at, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061214144526.GG21855@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain> <20061127182943.GE2352@gamma.logic.tuwien.ac.at> <20061127195940.1b90a897@localhost.localdomain> <20061128092930.GF2352@gamma.logic.tuwien.ac.at> <456C056D.2070008@gmail.com> <20061128120916.GG2352@gamma.logic.tuwien.ac.at> <456C2A6F.9020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C2A6F.9020406@gmail.com>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a Thank you & EOThread message :-)

On Tue, Nov 28, 2006 at 09:24:15PM +0900, Tejun Heo wrote:
> Dunno about IDE layer.  It has been done that way for long time and not 
> sure whether adding such option will happen, but for libata, hpa 
> handling is still not implemented ...

I'm now (since 2.6.19) happily using libata instead of ide
on that machine, no longer need to apply extra patches and will
do so until the harddisk finally dies.

> and it will have to be optional when 
> it gets implemented.  So, libata will have such option when it finally 
> receives implementation for hpa handling.

Glad to read that.

Thanks for all the patience with me.
