Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUGGPRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUGGPRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUGGPRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:17:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:35723 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265213AbUGGPRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:17:30 -0400
Date: Wed, 7 Jul 2004 16:17:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       braam@clusterfs.com
Subject: Re: [0/9] Lustre VFS patches for 2.6
Message-ID: <20040707151727.GA21293@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@clusterfs.com>, linux-kernel@vger.kernel.org,
	braam@clusterfs.com
References: <20040707124732.GA25877@clusterfs.com> <20040707125636.GA18058@infradead.org> <20040707151404.GJ5619@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707151404.GJ5619@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 06:14:04PM +0300, Oleg Drokin wrote:
> Well, there is not all that much "dead" code introduced (I hope). Esp. if some
> of the new intent code will be used by NFS, for example.

So let's wait until NFS uses it.

> And it is not all that dead too, there would be at least one off-tree user ;)

Which is equal to dead for all practical purposes of kernel maintaince.

