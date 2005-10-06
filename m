Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVJFSAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVJFSAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJFSAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:00:16 -0400
Received: from mail.shareable.org ([81.29.64.88]:64221 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751257AbVJFSAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:00:13 -0400
Date: Thu, 6 Oct 2005 19:00:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] atomic create+open
Message-ID: <20051006180006.GB19766@mail.shareable.org>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org> <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu> <1128619526.16534.8.camel@lade.trondhjem.org> <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu> <1128620528.16534.26.camel@lade.trondhjem.org> <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Secondly, Linux doesn't actually allow bind mounts on top of regular
> > files.
> 
> It does.  Try it.

The feature is even useful from time to time.

-- Jamie
