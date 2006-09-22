Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWIVUsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIVUsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWIVUsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:48:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:6584 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750767AbWIVUsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:48:46 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
Date: Fri, 22 Sep 2006 22:48:27 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609222248.27700.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 22:23, Christoph Lameter wrote:
> Here is an iniitial patch of alloc_pages_range (untested, compiles). 
> Directed reclaim missing. Feedback wanted. There are some comments in the 
> patch where I am at the boundary of my knowledge and it would be good if 
> someone could supply the info needed.

Looks like a good start. Surprising how little additional code it is.

-Andi
