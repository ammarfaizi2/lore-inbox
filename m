Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbUKWUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUKWUCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUKWTy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:54:56 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:61479 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261559AbUKWTx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:53:26 -0500
Date: Tue, 23 Nov 2004 20:53:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v2][1/21] Add core InfiniBand support (public headers)
Message-ID: <20041123195345.GC8367@mars.ravnborg.org>
Mail-Followup-To: Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <20041123814.p0AnYzTlx42JeVes@topspin.com> <20041123814.rXLIXw020elfd6Da@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123814.rXLIXw020elfd6Da@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:14:14AM -0800, Roland Dreier wrote:
> Add public headers for core InfiniBand support.  This can be thought
> of as a midlayer that provides an abstraction between low-level
> hardware drivers and upper level protocols (such as
> IP-over-InfiniBand).
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

After giving it a second thought my vote goes for: include/linux/infiniband
And just a few comments to the API towards drivers...

	Sam
