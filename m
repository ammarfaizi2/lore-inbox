Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWFGTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWFGTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFGTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:47:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:54472 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932393AbWFGTrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:47:24 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Updated sysctl documentation take #2
Date: Wed, 7 Jun 2006 12:46:41 -0700
Organization: OSDL
Message-ID: <20060607124641.516c7fff@localhost.localdomain>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1149709602 16202 10.8.0.54 (7 Jun 2006 19:46:42 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 7 Jun 2006 19:46:42 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 20:53:16 +0200
Diego Calleja <diegocg@gmail.com> wrote:

> Since people didn't like the "many small files" approach, I've moved
> it to directories containing index.txt files:
> 
> Documentation/sysctl/vm/index.txt
> Documentation/sysctl/net/core/index.txt
> Documentation/sysctl/net/unix/index.txt
> Documentation/sysctl/net/ipv4/index.txt
> Documentation/sysctl/net/ipv4/conf/index.txt
> Documentation/sysctl/net/ipv4/route/index.txt
> Documentation/sysctl/net/ipv4/neigh/index.txt
> 
> and so on.
> 
> As previously, this moves all sysctl documentation (including
> XFS and network) to Documentation/sysctl/*. The patch is
> against linus tree and weights more than 200K in size
> and is place at: http://www.terra.es/personal/diegocg/sysctl-docs
> 
> Comments?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

The network stuff was all in Documentation/networking/ip-sysctl.txt.
Someone else has already started fixing it.
