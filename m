Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWHICpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWHICpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWHICpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:45:23 -0400
Received: from ns.suse.de ([195.135.220.2]:4529 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030427AbWHICpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 3/6] x86_64: Remove apic_runs_main_timer
Date: Wed, 9 Aug 2006 04:31:43 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com> <20060809021726.23103.85003.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021726.23103.85003.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090431.43125.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 04:17, john stultz wrote:
> Part of the x86-64 cleanup for generic timekeeping. 
> Remove apic_runs_main_timer, on request from Andi, since it doesn't 
> work on many systems.

Ok for me.

-Andi
