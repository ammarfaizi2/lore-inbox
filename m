Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbTINMPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 08:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTINMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 08:15:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61456 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262389AbTINMPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 08:15:50 -0400
Date: Sun, 14 Sep 2003 14:15:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4 => NFSD problem on alpha
Message-ID: <20030914121540.GA549@alpha.home.local>
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet> <20030914113421.GA705@alpha.home.local> <16228.21909.391485.229455@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16228.21909.391485.229455@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 09:48:37PM +1000, Neil Brown wrote:
 
> I know what broke it.  Please try this patch and let me know.

It fixed it, and it works OK now. Congratulations for being so fast, Neil !

Thanks,
Willy

