Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFFN2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFFN2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFFN2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:28:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261394AbVFFN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:28:42 -0400
Date: Mon, 6 Jun 2005 14:28:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sk98Lin driver
Message-ID: <20050606132841.GA10486@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	linux-kernel@vger.kernel.org
References: <20050606131425.GF18862@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606131425.GF18862@mail.muni.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 03:14:25PM +0200, Lukas Hejtmanek wrote:
> Hello,
> 
> does someone have some experiences with this card? I'm using 8.16 or 8.18 driver
> (I do not want 6.x driver as it does not support suspend/resume).
> Basically it works but on UDP I get about 50 % packet loss when I try to receive
> 1Gbps. It's reported as frame and overruns.
> 
> Does someone have similar observation?

Can you give the skge driver that obsoletes sk98lin in -mm?

(insert rant here why it's still not in mainline)
