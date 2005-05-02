Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVEBUXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVEBUXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEBUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:23:36 -0400
Received: from main.gmane.org ([80.91.229.2]:41157 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261764AbVEBUVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:21:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Escombe <trial@dresco.co.uk>
Subject: Re: Suspend/Resume
Date: Mon, 2 May 2005 20:13:29 +0000 (UTC)
Message-ID: <loom.20050502T221228-244@post.gmane.org>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.253.64.24 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050416 Fedora/1.0.3-1.3.1 Firefox/1.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe <at> suse.de> writes:

> SATA suspend is completely broken right now, so I'm not surprised. You
> can shoe-horn this patch onto 2.6.12-rcX - it will reject for every
> ordered_flush addition, but should be trivial to fix up. If you have
> problems, let me know and I'll generate a proper diff for you.
> 

Thanks, will give that a go.. Is this a fix that's likely to make it into 2.6.12?

Regards,
Jon.

