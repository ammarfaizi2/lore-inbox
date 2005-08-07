Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVHGHM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVHGHM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVHGHM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:12:56 -0400
Received: from havoc.gtf.org ([69.61.125.42]:55214 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751173AbVHGHMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:12:55 -0400
Date: Sun, 7 Aug 2005 03:12:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: gcapatcch equivalent?
Message-ID: <20050807071250.GA7005@havoc.gtf.org>
References: <Pine.LNX.4.58.0508051157590.22353@skynet> <20050805151017.745f4188.akpm@osdl.org> <20050807043852.GB5271@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807043852.GB5271@mythryan2.michonline.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My gcapatch workalike is

	git checkout -f mybranch
	git diff master..HEAD > patch

Regards,

	Jeff



