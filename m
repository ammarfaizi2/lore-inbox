Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUAGQNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266238AbUAGQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:13:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43270 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265536AbUAGQMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:12:54 -0500
Date: Wed, 7 Jan 2004 16:12:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LVM <linux-lvm@sistina.com>
Subject: Re: [PATCH] 2.4.25--pre4 VFS lvm_snapshots
Message-ID: <20040107161251.A30329@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Xose Vazquez Perez <xose@wanadoo.es>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	LVM <linux-lvm@sistina.com>
References: <3FFC2B15.4000803@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FFC2B15.4000803@wanadoo.es>; from xose@wanadoo.es on Wed, Jan 07, 2004 at 04:51:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:51:49PM +0100, Xose Vazquez Perez wrote:
> hi,
> 
> This patch is necessary to be able to mount snapshots of journalling
> filesystems. It was flying around lvm for long time, years!!.
> And LiNUX distributions bring it, Red Hat at least since 7.x.
> So, it should be sure.

The patch still doesn't get better by that.  And even if it was this
would clearly be a feature for 2.6, not 2.4.

