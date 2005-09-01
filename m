Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVIARZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVIARZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVIARZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:25:37 -0400
Received: from smtp.istop.com ([66.11.167.126]:53642 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1030254AbVIARZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:25:36 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS, what's remaining
Date: Thu, 1 Sep 2005 13:27:42 -0400
User-Agent: KMail/1.8
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com>
In-Reply-To: <20050901104620.GA22482@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011327.42660.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 September 2005 06:46, David Teigland wrote:
> I'd like to get a list of specific things remaining for merging.

Where are the benchmarks and stability analysis?  How many hours does it 
survive cerberos running on all nodes simultaneously?  Where are the 
testimonials from users?  How long has there been a gfs2 filesystem?  Note 
that Reiser4 is still not in mainline a year after it was first offered, why 
do you think gfs2 should be in mainline after one month?

So far, all catches are surface things like bogus spinlocks.  Substantive 
issues have not even begun to be addressed.  Patience please, this is going 
to take a while.

Regards,

Daniel
