Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVC2W4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVC2W4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVC2W4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:56:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57807 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261608AbVC2W40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:56:26 -0500
Message-ID: <4249DD0D.7030708@pobox.com>
Date: Tue, 29 Mar 2005 17:56:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@lst.de>, wendyx@us.ltcfwd.linux.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixup newly added jsm driver
References: <20050329210735.GA5664@lst.de> <20050329134734.71c16b54.akpm@osdl.org>
In-Reply-To: <20050329134734.71c16b54.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
>>One more prematurely added drivers..
> 
> 
> This driver was first sent out for review a month ago, was upissued twice
> and generated over seventy linux-kernel emails including some from Russell
> and some from Greg.  It was by no means a "premature" addition.
> 
> One could say that it was inadequately reviewed, but how is one to
> determine that?  If the thing has been under discussion for a month and the
> submitter says "I've addressed all comments" then it's going to get merged.


I'd characterize it slightly differently than both of you:

It got a decent review, but from Christoph's list it looks like not all 
the issues raised during the review got addressed.

FWIW.

	Jeff


