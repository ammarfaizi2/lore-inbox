Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270262AbTGRSD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTGRSD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:03:58 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:3844 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270262AbTGRSD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:03:57 -0400
Date: Fri, 18 Jul 2003 19:18:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718191853.A11052@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030717102857.GA1855@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030717102857.GA1855@dualathlon.random>; from andrea@suse.de on Thu, Jul 17, 2003 at 12:28:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 12:28:57PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.21rc8aa1: 9910_shm-largepage-13.gz
> Only in 2.4.22pre6aa1: 9910_shm-largepage-16.gz
> 
> 	Thanks to Hugh for the help in porting the bigpages
> 	to the rewritten shmfs layer in 22pre. No idea at the moment if it
> 	works or if it only compiles.

Any reason you don't use a backport of hugetlbfs like the IA64 or
the RH AS3 tree?

