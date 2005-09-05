Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVIEQGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVIEQGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVIEQGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:06:34 -0400
Received: from bender.bawue.de ([193.7.176.20]:32975 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S932311AbVIEQGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:06:33 -0400
Date: Mon, 5 Sep 2005 18:06:10 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050905160610.GA7633@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Pavel Machek <pavel@ucw.cz>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050901202045.GB8728@sommrey.de> <20050905145145.GA2142@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905145145.GA2142@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 04:51:45PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch adds some experimental features to amd76x_pm, namely C3, NTH
> > and POS support.  These features are not enabled by default and are
> > intended for kernel hackers only.
> > 
> 
> Could those wait until ready?
There seems to be no development in this area at the moment.  That's why
these were separated into the -extra patch.  Just omit this -extra patch
and everything is fine :-)

-jo

-- 
-rw-r--r--  1 jo users 63 2005-09-05 08:37 /home/jo/.signature
