Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWBSWsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWBSWsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWBSWsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:48:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30653 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751118AbWBSWsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:48:24 -0500
Date: Sun, 19 Feb 2006 22:48:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219224820.GA14820@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com> <20060219220840.GA14153@infradead.org> <20060219221330.GC7974@redhat.com> <20060219221724.GA14408@infradead.org> <20060219222943.GD7974@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219222943.GD7974@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 05:29:43PM -0500, Dave Jones wrote:
> systemtap uses kprobes to export data through relayfs.

systemtap has never been anywhere near mainline despit me telling the
ibm folks to get the non-braindead parts in, so it simply doesn't matter.

