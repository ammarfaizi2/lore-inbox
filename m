Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUEJQfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUEJQfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUEJQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:35:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31376 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264856AbUEJQfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:35:00 -0400
Date: Mon, 10 May 2004 17:34:58 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Smart, James" <James.Smart@Emulex.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [(re)Announce] Emulex LightPulse Device Driver
Message-ID: <20040510163458.GD19144@parcelfarce.linux.theplanet.co.uk>
References: <3356669BBE90C448AD4645C843E2BF28034F92F0@xbl.ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3356669BBE90C448AD4645C843E2BF28034F92F0@xbl.ma.emulex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 12:33:35AM -0400, Smart, James wrote:
> The source for the driver can be downloaded from it's project page on source
> forge - http://sourceforge.net/projects/lpfcxxxx/ . Be sure to download the
> 20040507 snapshot - and the version for the 2.6 kernel.

You might want to consider changing the name of this driver.  aic7xxx
trips a number of spamfilters, so maybe just lpfc would be a good name
for it?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
