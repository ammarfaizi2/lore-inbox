Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJMJQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTJMJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:16:10 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:16513
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261546AbTJMJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:16:08 -0400
Date: Mon, 13 Oct 2003 05:15:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Bradford <john@grabjohn.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
In-Reply-To: <200310130832.h9D8WJ4g000157@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0310130501350.28426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
 <20031013011117.103de5e7.akpm@osdl.org> <200310130832.h9D8WJ4g000157@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, John Bradford wrote:

> > I guess that makes sense, although someone might want to swap onto a
> > ramdisk-backed file just for some testing purpose.
> 
> Or because some RAM is slower than the rest.  This came up a while ago
> on the list.

Could you possibly be referring to something else? How would this slower 
RAM be setup?

