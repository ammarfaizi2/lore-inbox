Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVCVSPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVCVSPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCVSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:13:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30922 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261494AbVCVSLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:11:50 -0500
Date: Tue, 22 Mar 2005 18:11:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 03/12] uml: export getgid for hostfs
Message-ID: <20050322181140.GA22149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20050322162123.890086BA6F@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322162123.890086BA6F@zion>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 05:21:23PM +0100, blaisorblade@yahoo.it wrote:
> 
> Export this symbol which is not satisfied currently. The code using it has
> been merged, so please export this symbol.

and it's still bogus, and you haven't replied when I mentioned it last time.

