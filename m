Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUKCQbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUKCQbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUKCQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:31:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261695AbUKCQbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:31:17 -0500
Date: Wed, 3 Nov 2004 11:31:03 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: james4765@verizon.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
Message-ID: <20041103133103.GB4109@logos.cnet>
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103152314.24869.56459.88722@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why is this obsolete? 

Users of Cyclades-Z still need to upload the firmware to the card.

I'm OK with removal of cyclomY.README.

On Wed, Nov 03, 2004 at 09:23:15AM -0600, james4765@verizon.net wrote:
> Remove obsolete file in drivers/char.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.cycladesZ linux-2.6.9/drivers/char/README.cycladesZ
> --- linux-2.6.9-original/drivers/char/README.cycladesZ	2004-10-18 17:54:32.000000000 -0400
> +++ linux-2.6.9/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
> @@ -1,8 +0,0 @@
> -
> -The Cyclades-Z must have firmware loaded onto the card before it will
> -operate.  This operation should be performed during system startup,
> -
> -The firmware, loader program and the latest device driver code are
> -available from Cyclades at
> -    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
> -
> -
