Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUCRVuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUCRVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:50:00 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:57747 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262972AbUCRVt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:49:58 -0500
Subject: Re: BK/Web improvements (includes patch server)
From: David Woodhouse <dwmw2@infradead.org>
To: andersen@codepoet.org
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040315114142.GA22039@codepoet.org>
References: <200403150616.i2F6Gu2Z030020@work.bitmover.com>
	 <20040315114142.GA22039@codepoet.org>
Content-Type: text/plain
Message-Id: <1079646591.17681.28.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Thu, 18 Mar 2004 21:49:51 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 04:41 -0700, Erik Andersen wrote:
> Of course, an alternative solution would be for someone to fix
> the kernel.org testing/cset/ scripts to not get wedged...

The 'bk pull' was stuck in recv() and seems to have been that way for
days. I've killed it.

-- 
dwmw2


