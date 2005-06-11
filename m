Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVFKQvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVFKQvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVFKQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:51:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39810 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261737AbVFKQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:51:18 -0400
Date: Sat, 11 Jun 2005 17:51:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050611165115.GA1012@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, sdietrich@mvista.com
References: <1118214519.4759.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118214519.4759.17.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folks, can you please take this RT stuff of lkml?  And with that I don't
mean the highlevel discussions what makes sense, but specific patches that
aren't related to anything near mainline.  Just create your own list, like
any other far from mainline project does.

Thanks.

