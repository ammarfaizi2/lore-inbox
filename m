Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUIJUhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUIJUhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUIJUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:37:37 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2310 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267770AbUIJUhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:37:36 -0400
Date: Fri, 10 Sep 2004 22:37:33 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch 17/25]  drivers/tc/zs.c MIN/MAX removal
In-Reply-To: <E1C2cAK-0007RF-2m@sputnik>
Message-ID: <Pine.LNX.4.58L.0409102233570.20057@blysk.ds.pg.gda.pl>
References: <E1C2cAK-0007RF-2m@sputnik>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 janitor@sternwelten.at wrote:

> Patch (against 2.6.7) removes unnecessary min/max macros and changes
> calls to use kernel.h macros instead.
> 
> Feedback is always welcome

 The current version of the driver (that is in the MIPS/Linux CVS) has
already been updated and uses the preferred min() macro instead.  Thanks
for your effort anyway.

  Maciej
