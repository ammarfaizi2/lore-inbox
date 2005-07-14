Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbVGNWjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbVGNWjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVGNWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:38:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3200 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263168AbVGNWiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:38:08 -0400
Date: Thu, 14 Jul 2005 23:38:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add security_task_post_setgid
Message-ID: <20050714223807.GA25671@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 11:42:46PM +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> the following patch adds a post_setgid() security hook, and necessary dummy 
> funcs.

... and why exactly would we want these?

