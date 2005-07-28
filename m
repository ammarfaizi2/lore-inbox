Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVG1OhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVG1OhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVG1OTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:19:09 -0400
Received: from sommereik.ii.uib.no ([129.177.16.236]:60649 "EHLO
	sommereik.ii.uib.no") by vger.kernel.org with ESMTP id S261472AbVG1OSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:18:36 -0400
Subject: Re: [discuss] x86_64-2.6.13rc3-1 released
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
In-Reply-To: <20050727114702.GA1482@wotan.suse.de>
References: <20050727114702.GA1482@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 16:18:11 +0200
Message-Id: <1122560292.3196.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.5.1 (2.3.5.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 27,.07.2005 kl. 13.47 +0200, skrev Andi Kleen:
> A new version of the x86-64 patch for the linux kernel has been
> released. It contains my queued patches and some work in progress.
> Patch against the 2.6.13rc3 kernel.org kernel.
> Should be still fairly usable. Please test.

> 
> ptrace-ebp
> Fix 32bit strace for 6 argument system calls

This breaks all 32bit apps for me.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

