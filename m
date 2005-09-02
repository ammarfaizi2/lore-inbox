Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVIBR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVIBR1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVIBR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:27:54 -0400
Received: from fmr23.intel.com ([143.183.121.15]:53679 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750738AbVIBR1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:27:53 -0400
Date: Fri, 2 Sep 2005 09:57:02 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050902135701.GA4470@linux.intel.com>
References: <20050901035542.1c621af6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:55:42AM -0700, Andrew Morton wrote:
>  Dropped (I have it in a new AIO patch series but I took yet another look at
>  all the AIO stuff and felt queasy)

What's the nature of the queasiness?  Is it something that can be addressed 
by rewriting the patches, or just general worries about adding another 
feature?  The status quo is not acceptable.

		-ben
