Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVGQI2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVGQI2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGQI2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 04:28:54 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:54608 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261212AbVGQI2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 04:28:53 -0400
Date: Sun, 17 Jul 2005 10:28:52 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       olh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much, for no good reason.
Message-ID: <20050717082852.GA3786@bitwizard.nl>
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de> <20050710.144910.15269860.davem@davemloft.net> <42D1A039.9090807@pobox.com> <29495f1d050710211862c4e543@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d050710211862c4e543@mail.gmail.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 09:18:15PM -0700, Nish Aravamudan wrote:
> one for the SCSI subsystem. If those individual driver maintainers'
> files are being modified, should they be CC'ed, or is the big patch
> just sent to the SCSI maintainer (in this example)? I just want to
> make sure the correct patch-chain is respected.

As a patch maintainer, CCed on ONE of the 82 patches, I wouldn't have
minded getting CCed on a patch that included the change to my driver. 
(as chunk xx/82 in the diff).

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
