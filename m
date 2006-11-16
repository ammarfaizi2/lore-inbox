Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424100AbWKPOXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424100AbWKPOXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424102AbWKPOXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:23:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43205 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424100AbWKPOXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:23:36 -0500
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86-64 add Intel BTS cpufeature bit and detection (take 2)
Date: Thu, 16 Nov 2006 15:23:30 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061115213241.GC17238@frankl.hpl.hp.com> <20061116142049.GE18162@frankl.hpl.hp.com>
In-Reply-To: <20061116142049.GE18162@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161523.30922.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 15:20, Stephane Eranian wrote:
> Andi,
> 
> Here is a small patch for x86-64 which adds a cpufeature flag and
> detection code for Intel's Branch Trace Store (BTS) feature. This
> feature can be found on Intel P4 and Core 2 processors among others.
> It can also be used by perfmon.

Added thanks

-Andi
