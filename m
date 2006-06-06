Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750875AbWFFAcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFFAcI (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWFFAcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:32:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:28897 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750875AbWFFAcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:32:06 -0400
Subject: Re: [PATCH 0/9] PCI power management updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149497136.7831.154.camel@localhost.localdomain>
References: <1149497136.7831.154.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 10:31:33 +1000
Message-Id: <1149553894.559.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 04:45 -0400, Adam Belay wrote:
> Hi All,
> 
> This series of patches is my first pass in an effort to improve PCI
> power management.  They are against 2.6.17-rc5.  The changes include
> various PCI PM improvements and fixes, with a focus on low-level
> infrastructure.  All code has been tested on a limited set of hardware,
> and seems to work well, but additional testing coverage will likely be
> necessary.  I look forward to any suggestions or comments.

Looks really good overall, a few comments coming.

Ben.


