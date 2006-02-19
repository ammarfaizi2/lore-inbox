Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWBSWNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWBSWNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBSWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:13:48 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:53213 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751070AbWBSWNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:13:47 -0500
Date: Sun, 19 Feb 2006 17:13:30 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Paul Mundt <lethal@linux-sh.org>,
       Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219221330.GC7974@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
	zanussi@us.ibm.com, linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com> <20060219220840.GA14153@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219220840.GA14153@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 10:08:40PM +0000, Christoph Hellwig wrote:

 > > What about the userspace visible API for things already using relayfs,
 > There's no existing in-tree user of relayfs.

wtf ? since when has userspace been 'in-tree' ?

		Dave

