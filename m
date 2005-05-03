Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVECPX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVECPX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVECPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:23:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27784 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261745AbVECPXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:23:48 -0400
Subject: Re: Garbage on serial console after serial driver loads
From: David Woodhouse <dwmw2@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050503151159.GL1221@smtp.west.cox.net>
References: <20050328173652.GA31354@linuxace.com>
	 <20050328200243.C2222@flint.arm.linux.org.uk>
	 <1115129833.4446.23.camel@hades.cambridge.redhat.com>
	 <20050503151159.GL1221@smtp.west.cox.net>
Content-Type: text/plain
Date: Tue, 03 May 2005 16:23:40 +0100
Message-Id: <1115133820.16187.4.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 08:11 -0700, Tom Rini wrote:
> I don't recall the problem well enough right now, but I'll go toss this
> into a current git tree and let you know.

With what hardware are you testing? Was this really a NatSemi SuperIO
chip, or was it a false positive in the detection?

-- 
dwmw2

