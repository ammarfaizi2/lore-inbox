Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUGAQpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUGAQpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUGAQpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:45:21 -0400
Received: from users.linvision.com ([62.58.92.114]:5274 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S266048AbUGAQpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:45:16 -0400
Date: Thu, 1 Jul 2004 18:45:14 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Jason Mancini <xorbe@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
Message-ID: <20040701164514.GA19407@bitwizard.nl>
References: <1088073870.17691.8.camel@xorbe.dyndns.org> <20040624150122.GB5068@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624150122.GB5068@apps.cwi.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 05:01:22PM +0200, Andries Brouwer wrote:
> Config item? No. There are far too many.
> 
> Automatically enabling? No - that code must be deleted, like you did.
> Anyone with such a CDROM can give the "cruft" mount option herself.

Agreed, But how about printing a warning (once!) if in the old days
the cruft option would have been enabled automatically?

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
