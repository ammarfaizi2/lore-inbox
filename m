Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWHXQoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWHXQoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWHXQoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:44:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751381AbWHXQow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:44:52 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
References: <32640.1156424442@warthog.cambridge.redhat.com>
	 <20060824152937.GK19810@stusta.de>
	 <1156434274.3012.128.camel@pmac.infradead.org>
	 <20060824155814.GL19810@stusta.de>
	 <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:44:24 +0100
Message-Id: <1156437864.3012.132.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 18:39 +0200, Jan Engelhardt wrote:
> Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
> CONFIG_EMBEDDED.

Let's just call it CONFIG_AUNT_TILLIE and have done with it.

-- 
dwmw2

