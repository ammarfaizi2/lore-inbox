Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVBDQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVBDQVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbVBDQVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:21:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41870 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261852AbVBDQUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:20:49 -0500
Date: Fri, 4 Feb 2005 16:20:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: maxer <maxer@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SysKonnect sk98lin Gigabit lan missing in action from 2.6.10 on
Message-ID: <20050204162044.GA21965@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	maxer <maxer@xmission.com>, linux-kernel@vger.kernel.org
References: <42038994.20401@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42038994.20401@xmission.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:41:24AM -0700, maxer wrote:
> What is the status of sk98lin? Do we have to wait until Syskonnect gets 
> their act together
> and write a new driver for 2.6.10?
> 
> Their latest is Oct 2004 and not at all compatible with 2.6.10 and beyond.

Use the driver intree or better Stephen's rewrite.

