Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265064AbUEKXiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265064AbUEKXiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUEKXiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:38:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:18082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265065AbUEKXho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:37:44 -0400
Date: Tue, 11 May 2004 16:38:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: ashok.raj@intel.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040511163801.2a657b07.akpm@osdl.org>
In-Reply-To: <20040511161653.49e836e5.pj@sgi.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040511161653.49e836e5.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> On the off chance that
> others find this way of phrasing it helpful, I post it here for the
> record.

Thanks, I added that to the changelog.  If you think additional code
commentary is needed, please send patches.

I guess I'm not doing anything useful with these patches.  Is it OK with
everyone if I scoot them over to davidm?
