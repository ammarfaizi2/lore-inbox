Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUEMKpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUEMKpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUEMKpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:45:23 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:29457 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264072AbUEMKpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:45:21 -0400
Date: Thu, 13 May 2004 11:45:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513114520.A8442@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040513032736.40651f8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 03:27:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +hugetlb_shm_group-sysctl-gid-0-fix.patch
> 
>  Don't make gid 0 special for hugetlb shm.

As Oracle has agreed on fixing their DB to use hugetlbfs could we
please stop doctoring around on this broken patch and revert it.

Except for for you I've seen no one defending it, not even the Intel
folks that submitted it..

