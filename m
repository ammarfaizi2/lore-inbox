Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVBXO2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVBXO2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVBXO2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:28:52 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:38439 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S262356AbVBXO2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:28:38 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-mtd@lists.infradead.org,
       "Eric W. Biederman" <ebiederman@lnxi.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/mtd/maps/ich2rom.c
References: <20050224111125.GH8651@stusta.de>
	<1109251232.5420.55.camel@hades.cambridge.redhat.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 24 Feb 2005 07:28:32 -0700
In-Reply-To: <1109251232.5420.55.camel@hades.cambridge.redhat.com>
Message-ID: <m3acpurq0f.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> On Thu, 2005-02-24 at 12:11 +0100, Adrian Bunk wrote:
> > drivers/mtd/maps/ich2rom.c is completely unused because it was renamed 
> > to drivers/mtd/maps/ichxrom.c .
> > 
> > This patch removes the stale ich2rom.c file.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ack.

ack.

Eric
