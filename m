Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269989AbUJHNeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269989AbUJHNeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbUJHNeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:34:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:27813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S269980AbUJHNaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:30:55 -0400
Subject: Re: [PATCH] PPC64 Replace cmp instructions with cmpw/cmpd
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <16742.36752.461737.252196@cargo.ozlabs.ibm.com>
References: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
	 <1097228724.318.65.camel@hades.cambridge.redhat.com>
	 <16742.36752.461737.252196@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1097242246.318.107.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 08 Oct 2004 14:30:46 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 23:01 +1000, Paul Mackerras wrote:
> Looks fine to me.  Andrew/Linus, please apply.  Or, if David resends
> with a signed-off-by, I'll add mine and send it on. :)

Oops I forgot again; must try harder.

Here's a few copies. Feel free to cut them out and attach them to any
patch I send you without a question mark. When you run out, let me know
and I'll send you some more :)

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

-- 
dwmw2

