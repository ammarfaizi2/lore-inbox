Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWBSWyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWBSWyu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWBSWyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:54:50 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:58808 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751129AbWBSWyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:54:50 -0500
Date: Sun, 19 Feb 2006 17:54:37 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Paul Mundt <lethal@linux-sh.org>,
       Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219225437.GE7974@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
	zanussi@us.ibm.com, linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com> <20060219220840.GA14153@infradead.org> <20060219221330.GC7974@redhat.com> <20060219221724.GA14408@infradead.org> <20060219222943.GD7974@redhat.com> <20060219224820.GA14820@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219224820.GA14820@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 10:48:20PM +0000, Christoph Hellwig wrote:
 > On Sun, Feb 19, 2006 at 05:29:43PM -0500, Dave Jones wrote:
 > > systemtap uses kprobes to export data through relayfs.
 > 
 > systemtap has never been anywhere near mainline despit me telling the
 > ibm folks to get the non-braindead parts in, so it simply doesn't matter.

the kernel bits that matter are generated at runtime.
I don't see anything particularly interesting in the source tree
that is worthwhile submitting.

		Dave

