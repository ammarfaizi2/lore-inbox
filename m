Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTKENkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 08:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKENkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 08:40:05 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:30606 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262898AbTKENkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 08:40:02 -0500
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       "\"Alistair J Strachan\"" <alistair@devzero.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031105102339.D29912@devserv.devel.redhat.com>
References: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>
	 <20031105102339.D29912@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1068039598.6065.78.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-3.dwmw2.1) 
Date: Wed, 05 Nov 2003 13:39:59 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-05 at 10:23 +0100, Arjan van de Ven wrote:
> On Wed, Nov 05, 2003 at 10:10:14AM +0300, "Andrey Borzenkov"  wrote:
> 
> > Mandrake and AFAIK RedHat ship single 2.4 kernel source that allos building
> 
> the 2.6 rpms I'm working on don't do this anymore. What Dave Jones will do
> in his RPMs I don't know.

Hopefully the out-of-source-tree build will allow this to be a lot nicer
than it was in 2.4. 

-- 
dwmw2

