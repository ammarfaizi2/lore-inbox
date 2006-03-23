Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWCWMdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWCWMdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCWMdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:33:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34281 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751202AbWCWMdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:33:46 -0500
Date: Thu, 23 Mar 2006 12:33:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans
Message-ID: <20060323123345.GB10774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060322205305.0604f49b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322205305.0604f49b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gdth-add-execute-firmware-command-abstraction.patch
> 
>   That's up to Christoph

This has been tersted and found to work.  It'll go in through the scsi tree
eventually.

> areca-raid-linux-scsi-driver.patch
> areca-raid-linux-scsi-driver-update4.patch
> 
>   Would be nice.  Needs followup from the scsi team.

I gave it a quick look and it still looks wired.  I'll try to allocate
some time for a real review.

