Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFNOs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFNOs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFNOpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:45:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:62925 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261255AbVFNOfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:35:51 -0400
Date: Tue, 14 Jun 2005 20:03:25 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: rcuref APIs
Message-ID: <20050614143325.GI4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614142735.GB4557@in.ibm.com> <20050614142818.GC4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614142818.GC4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 07:58:18PM +0530, Dipankar Sarma wrote:
> 
> 
> Adds a set of primitives to do reference counting for objects
> that are looked up without locks using RCU.
> 
> Signed-off-by: Ravikiran Thirumalai <kiran_th@gmail.com>
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> 

Should be 2 of 6. Sorry again.

Dipankar
