Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVEGMk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVEGMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVEGMk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:40:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263087AbVEGMkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:40:46 -0400
Date: Sat, 7 May 2005 13:40:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, ayyappan.veeraiyan@intel.com,
       ganesh.venkatesan@intel.com, john.ronciak@intel.com, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ixgb/: possible cleanups
Message-ID: <20050507124041.GA22088@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ganesh Venkatesan <ganesh.venkatesan@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, ayyappan.veeraiyan@intel.com,
	ganesh.venkatesan@intel.com, john.ronciak@intel.com,
	jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050506211834.GM3590@stusta.de> <5fc59ff3050506153523cd12dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc59ff3050506153523cd12dd@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 03:35:52PM -0700, Ganesh Venkatesan wrote:
> Adrian:
> 
> Some of your suggestions are already part of the driver we are
> currently testing. This was based partly on your Feb '05 patch. We
> will not be able to apply your patch as is since some of the changes
> are in part of code that is shared with other drivers that are not
> GPLd.

I don't think Adrian can claim copyright on code removal even if he
wanted to (which I doubt :))

