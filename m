Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWF2RhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWF2RhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWF2RhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:37:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64777 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751096AbWF2RhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:37:20 -0400
Date: Thu, 29 Jun 2006 18:37:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Andrey Borzenkov <arvidjaar@mail.ru>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris@amavis.tls.msk.ru, Wedgwood@vger.kernel.org
Subject: Re: [PATCH 07/13] SERIAL: PARPORT_SERIAL should depend on SERIAL_8250_PCI
Message-ID: <20060629173710.GE9709@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Andrey Borzenkov <arvidjaar@mail.ru>,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>, Chris@amavis.tls.msk.ru,
	Wedgwood@vger.kernel.org
References: <20060620114527.934114000@sous-sol.org> <20060620114733.957367000@sous-sol.org> <44A40E68.9080906@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A40E68.9080906@tls.msk.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 09:31:20PM +0400, Michael Tokarev wrote:
> I've no idea how this patch slipped into 2.6.16 -stable queue in the
> first place... ;)

Probably because I didn't pay enough attention to the review mails.
I wasn't expecting it to go into 2.6.16, so thought little of it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
