Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWKUVcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWKUVcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWKUVcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:32:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161343AbWKUVcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:32:54 -0500
Date: Tue, 21 Nov 2006 16:31:39 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mattia Dongili <malattia@linux.it>, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061121213139.GC9651@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mattia Dongili <malattia@linux.it>, cpufreq@lists.linux.org.uk
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121212424.GQ5200@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 10:24:24PM +0100, Adrian Bunk wrote:

 > Subject    : CPU_FREQ_GOV_ONDEMAND=y compile error
 > References : http://lkml.org/lkml/2006/11/17/198
 > Submitter  : alex1000@comcast.net
 > Caused-By  : Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
 >              commit 05ca0350e8caa91a5ec9961c585c98005b6934ea
 > Handled-By : Mattia Dongili <malattia@linux.it>
 > Patch      : http://lkml.org/lkml/2006/11/17/236
 > Status     : patch available

not a regression, easily worked around, queued for .20

		Dave

-- 
http://www.codemonkey.org.uk
