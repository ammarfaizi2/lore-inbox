Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUKCVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUKCVPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKCVO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:14:59 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:57095 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261888AbUKCVNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:13:55 -0500
Date: Wed, 3 Nov 2004 21:13:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041103211353.GA24084@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41894779.10706@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41894779.10706@techsource.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:02:49PM -0500, Timothy Miller wrote:
> I'm just curious about why there seems to be so much work going into 
> supporting a wide range of GCC versions.  If people are willing to 
> download and compile a new kernel (and migrating from 2.4 to 2.6 is 
> non-trivial for some systems, like RH9), why aren't they willing to also 
> download and build a new compiler?

Because the new compilers are a lot slower.
