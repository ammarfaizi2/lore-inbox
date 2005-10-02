Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJBXtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJBXtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVJBXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:49:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751154AbVJBXtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:49:07 -0400
Date: Sun, 2 Oct 2005 19:48:53 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <200510021932.00969.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.63.0510021948180.27456@cuia.boston.redhat.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4340627F.6010303@shaw.ca>
 <200510021932.00969.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Gene Heskett wrote:

> Ahh, yes and no, Robert.  The un-answered question, for that
> 512 processor Altix system, would be "but does it run things 512
> times faster?"  Methinks not, by a very wide margin.  Yes, do a lot
> of unrelated things fast maybe, but render a 30 megabyte page with
> ghostscript in 10 milliseconds?  Never happen IMO.

You haven't explained us why you think your proposal
would allow Linux to circumvent Amdahl's law...

-- 
All Rights Reversed
