Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbTHZPr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHZPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:47:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41914 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262463AbTHZPrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:47:25 -0400
Date: Tue, 26 Aug 2003 17:45:53 +0200
From: Jens Axboe <axboe@suse.de>
To: mike.miller@hp.com
Cc: akpm@digeo.com, francis.wiran@hp.com, linux-kernel@vger.kernel.org
Subject: Re: cciss fix for 2.6.0-test4
Message-ID: <20030826154553.GB30357@suse.de>
References: <20030826145503.GA1000@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826145503.GA1000@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, mike.miller@hp.com wrote:
> The following patch fixes a panic in the cciss driver during driver initialization. It was built & tested against 2.6.0-test4.
> Authored by Francis Wiran of Hewlett-Packard.

A slightly different one was sent to Linus yesterday, I suspect it will
show up later today.

-- 
Jens Axboe

