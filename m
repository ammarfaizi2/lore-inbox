Return-Path: <linux-kernel-owner+w=401wt.eu-S1755234AbXAAQ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbXAAQ3I (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbXAAQ3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:29:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4665 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755236AbXAAQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:29:04 -0500
Date: Thu, 28 Dec 2006 13:36:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Philip Langdale <philipl@overt.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards
Message-ID: <20061228133652.GE3955@ucw.cz>
References: <458C22C0.1080307@vmware.com> <458C290B.4060003@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458C290B.4060003@overt.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hi all,
> > 
> > Thanks to the generous donation of an SDHC card by John Gilmore, and the
> > surprisingly enlightened decision by the SD Card Association to publish
> > useful specs, I've been able to bash out support for SDHC. The changes
> > are not too profound:
> 
> So I sent that with the wrong From: address (damn you thunderbird!). Please
> reply to my personal address (this one) and not my work one. :-)

Would you describe what SDHC is? I know SD flash cards, and IIRC SDIO
cards exist, with functionality such as bluetooth...? But SDHC?

-- 
Thanks for all the (sleeping) penguins.
