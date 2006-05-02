Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWEBQae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWEBQae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWEBQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:30:34 -0400
Received: from alfie.demon.co.uk ([80.177.172.67]:42757 "EHLO
	alfie.demon.co.uk") by vger.kernel.org with ESMTP id S964912AbWEBQad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:30:33 -0400
Date: Tue, 2 May 2006 17:30:31 +0100
From: Nick Holloway <Nick.Holloway@pyrites.org.uk>
To: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] mm: improve remapping of vmalloc regions
Message-ID: <20060502163031.GA32629@pyrites.org.uk>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 05:06:09PM +0000, Nick Piggin wrote:
> Not tested, because I don't have any of the hardware, but it seems
> compiles OK.

I have a CPIA webcam, so I have taken 2.6.17-rc3 and added your patchset
on top.

The patch is working fine, using "motion" as the video4linux application
accessing the parallel port CPIA webcam.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
