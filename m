Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271599AbTGQWNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271600AbTGQWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:13:01 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:14608
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271599AbTGQWM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:12:27 -0400
Date: Thu, 17 Jul 2003 15:27:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030717222722.GC2289@matchmail.com>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Chris Mason <mason@suse.com>
References: <20030717102857.GA1855@dualathlon.random> <200307180013.38078.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307180013.38078.m.c.p@wolk-project.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:13:38AM +0200, Marc-Christian Petersen wrote:
> VMware4 Workstation
> -------------------
> 
> 2.4.22-pre[6|6aa1]: ~ 1 minute 02 seconds from: Start this virtual machine ...
> 2.4.22-pre2       : ~          30 seconds from: Start this virtual machine ...
> 
> ... to start up Windows 2000 Professional completely.
> 
> Well, personally I don't care about the slowdown of vmware startup with a VM 
> but there may be many other slowdows?!

Can you try a stock -pre kernel, say pre[256], and see where the additional
time starts?
