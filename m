Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTD3OHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTD3OHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:07:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:54740 "EHLO
	dyn95394153.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261244AbTD3OHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Date: Wed, 30 Apr 2003 09:19:45 -0500
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030429161128.3b8c762b.rddunlap@osdl.org> <20030430000236.GS10374@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030430000236.GS10374@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304300919.45404.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 April 2003 19:02, viro@parcelfarce.linux.theplanet.co.uk 
wrote:

> 	* ditto for JFS - again, a bunch of functions use positive error
> values.

Yeah, we've changed some of this from the way it was in OS/2, but we 
haven't gone through everything.  I'll put it on my todo list.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

