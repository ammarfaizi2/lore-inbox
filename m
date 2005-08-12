Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVHLSvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVHLSvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVHLSvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49294 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751214AbVHLSu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:50:58 -0400
Date: Fri, 12 Aug 2005 20:50:57 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812185056.GH22901@wotan.suse.de>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com> <42FCB86C.5040509@fujitsu-siemens.com> <20050812145725.GD922@wotan.suse.de> <20050812111916.A15541@unix-os.sc.intel.com> <20050812182228.GE22901@wotan.suse.de> <20050812114033.B15541@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812114033.B15541@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure if we ever support CPUs with different APIC versions. That will
> probably require some ACPI SPEC changes too..
> 
> I would say, for now just follow the i386 code.

Ok I applied the patch. Thanks.

-Andi
