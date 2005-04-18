Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVDRFVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVDRFVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVDRFVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:21:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261677AbVDRFVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:21:36 -0400
Date: Mon, 18 Apr 2005 06:21:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH i386] Live Patching Function on 2.6.11.7
Message-ID: <20050418052135.GA16630@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org
References: <4263277F.6020206@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263277F.6020206@lab.ntt.co.jp>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:20:31PM +0900, Takashi Ikebe wrote:
> The patch was over 50k, so I separate it to each architecture and in line..
> 
> This patch add function called "Live patching" which is defined on
> OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7 kernel.

Traditionally beeing in OSDL specs was a very good reason not to merge patches.

Can you please come up with real arguments instead of this requirements
bullshit.  Also I hope OSDL would invest their money in more useful things
than CGL, why has this idiocy still not stopped?

