Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbUKRVty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbUKRVty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUKRVr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:47:59 -0500
Received: from newton.linux4geeks.de ([193.30.1.1]:64139 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S263009AbUKRVrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:47:01 -0500
From: Sven Ladegast <sven@linux4geeks.de>
Organization: Linux4Geeks
To: linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine WOL
Date: Thu, 18 Nov 2004 22:46:59 +0100
User-Agent: KMail/1.6.2
References: <20041118181045.GC28972@k3.hellgate.ch>
In-Reply-To: <20041118181045.GC28972@k3.hellgate.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411182246.59461.sven@linux4geeks.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 November 2004 19:10, Roger Luethi wrote:

> The via-rhine code has changed in the 2.6.9/2.6.10 time frame: Legacy
> WOL is turned off (mostly), so it will not work unless you explicitly
> tell the driver to enable WOL. You can do this using ethtool(8).
>
> If WOL used to work with your Rhine hardware and now all of a sudden
> doesn't, check first if you enabled WOL using ethtool.
>
> Roger

That was the information I needed... :o)
I just wondered why my machine did not want to wake up.

Sven
-- 
Sven Ladegast, Friedrich-Fröbel-Straße 11, 93310 Arnstadt / Germany
Phone: +49-175-5334308, PGP-key: 0x5856A5ED

