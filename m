Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVAQDzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVAQDzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVAQDzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:55:16 -0500
Received: from nacho.alt.net ([207.14.113.18]:23951 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S262682AbVAQDwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:52:46 -0500
Date: Sun, 16 Jan 2005 19:52:37 -0800 (PST)
To: Ricky Beam <jfbeam@bluetronic.net>
cc: Peter Daum <gator@cs.tu-berlin.de>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
In-Reply-To: <Pine.GSO.4.33.0501101212500.6604-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.44.0501161948350.22840-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Ricky Beam wrote:
> On Mon, 10 Jan 2005, Peter Daum wrote:
> >On Mon, 10 Jan 2005, Christoph Hellwig wrote:
> >> The change came from the driver maintainer at 3ware.  Get the updated
> >> tools from their website.
> >
> >Which website do you mean? The programs in the download section of
> >"www.3ware.com" are just the ones that don't work anymore.
> 
> Yeap.  The "idiot" removed the proc interface from the driver before
> publishing the updated tools  -- and I said so at the time.  At the time
> the interface was removed, the new tools weren't available - period.  They
> are still "beta" today (several months later.)
> 
> Just put the procfs code back in the driver in your local tree and
> walk away.  That's what I did -- but it doesn't look like I commited
> it to any BK tree :-( (and that box is *ahem* powered off)

Or just grab the latest (version 9.1.5.2) 3dm and tw_cli software from the
3ware web site.  These may not be listed as being for your version of the
card, but they will work with the new driver.

Chris

