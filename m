Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWCSXV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWCSXV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCSXV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:21:28 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:17093 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751222AbWCSXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:21:27 -0500
Date: Sun, 19 Mar 2006 23:17:56 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org,
       mactel-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060319231756.GA8966@srcf.ucam.org>
References: <20060319184325.GA7605@srcf.ucam.org> <20060319212901.GA30843@lists.us.dell.com> <20060319213259.GA8602@srcf.ucam.org> <20060319224939.GA712@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319224939.GA712@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 04:49:40PM -0600, Matt Domsch wrote:

> Sorry, I did mean to post a link to the latest efibootmgr that has
> this fixed:

Thanks - the copy I had was rather older than I thought. Sorry about the 
confusion.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
