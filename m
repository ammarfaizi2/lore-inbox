Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIBRZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIBRZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVIBRZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:25:35 -0400
Received: from xenotime.net ([66.160.160.81]:30594 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750725AbVIBRZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:25:35 -0400
Date: Fri, 2 Sep 2005 10:25:32 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mark Underwood <basicmark@yahoo.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to create patch statistics?
In-Reply-To: <20050902172232.62821.qmail@web30308.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.50.0509021024070.3251-100000@shark.he.net>
References: <20050902172232.62821.qmail@web30308.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Mark Underwood wrote:

> Sorry to ask such a n00b question, but how do you
> create the patch statistics that many people show at
> the top of a patch set? I couldn’t see it the the
> SubmittingPatches doc and google didn’t help (or I
> don’t know what to look for ;)

use 'diffstat'

most distros have a package for it.
it's home is here (is this current?):
http://invisible-island.net/diffstat/

-- 
~Randy
