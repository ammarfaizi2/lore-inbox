Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272820AbTHISFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273071AbTHISFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 14:05:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58003 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S272820AbTHISFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 14:05:07 -0400
Subject: Re: time for some drivers to be removed?
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: spse@secret.org.uk, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727153118.GP22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	 <20030727153118.GP22218@fs.tum.de>
Content-Type: text/plain
Message-Id: <1060452295.29776.1.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Sat, 09 Aug 2003 19:04:55 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: bunk@fs.tum.de, spse@secret.org.uk, rpjday@mindspring.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 16:31, Adrian Bunk wrote:

> A first patch is at
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0770.html
> 
> I'll send an updated patch against -test2 or -test3.

Please don't make blkmtd depend on CONFIG_BROKEN. Its maintainer sent a
patch to Linus recently -- further resends seem to be required.

-- 
dwmw2


