Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUJNWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUJNWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUJNWP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:15:29 -0400
Received: from holomorphy.com ([207.189.100.168]:25733 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267438AbUJNWJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:09:24 -0400
Date: Thu, 14 Oct 2004 15:09:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] move semaphore definitions to waitlock_types.h
Message-ID: <20041014220913.GB5607@holomorphy.com>
References: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:45:20PM +0200, Roman Zippel wrote:
> This moves the definition and initializer of semaphore, rw_semaphore and
> wait queue structures to waitlock_types.h.

ISTR removing the WAITQUEUE_DEBUG bits from all arches (AFAICT only m32r
has any of that crap in 2.6.9-rc3); what kernel version this against?


-- wli
