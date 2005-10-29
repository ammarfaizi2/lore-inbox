Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVJ2Dcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVJ2Dcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJ2Dcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:32:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751120AbVJ2Dcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:32:42 -0400
Date: Fri, 28 Oct 2005 23:32:29 -0400
From: Dave Jones <davej@redhat.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051029033229.GA13257@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	linux-kernel@vger.kernel.org
References: <20051028205833.GM2533@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028205833.GM2533@mail.muni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 10:58:33PM +0200, Lukas Hejtmanek wrote:
 > Hello,
 > 
 > I have system with 2 Pentium 4 Xeon EM64T processors using 4GB of RAM.
 > 
 > Kernel is 2.6.13.4 compiled for x86_64 architecture.
 > 
 > Btw, /proc/cpuinfo reports, that only 36 bits are availalable for physical 
 > memory. Not 40.

That should be fixed in 2.6.14

		Dave

