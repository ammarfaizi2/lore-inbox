Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTEGPUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTEGPUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:20:52 -0400
Received: from holomorphy.com ([66.224.33.161]:9360 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264045AbTEGPUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:20:51 -0400
Date: Wed, 7 May 2003 08:33:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030507153318.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steven Cole <elenstev@mesatop.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@digeo.com>
References: <3EB8DBA0.7020305@aitel.hist.no> <1052304024.9817.3.camel@rth.ninka.net> <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <1052320817.2163.159.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052320817.2163.159.camel@spc9.esa.lanl.gov>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from:
>> I'm trying to track down testers with i810's to reproduce the issue,
>> but the usual suspects and helpers aren't awake yet (most/all of my
>> target systems are headless, though I regularly abuse my laptop, which
>> appears to S3/Savage -based and so isn't useful for this).

On Wed, May 07, 2003 at 09:20:17AM -0600, Steven Cole wrote:
> Hey, I've got one of those.  Well, an i810 anyway.
> [steven@spc1 linux-2.5.69-mm2]$ dmesg | grep 810
> agpgart: Detected an Intel i810 E Chipset.
> [drm] Initialized i810 1.2.1 20020211 on minor 0

Okay, we're probably going to need Helge Hafting to test things himself.


-- wli
