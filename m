Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbULCWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbULCWQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbULCWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:16:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:40320
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262403AbULCWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:16:42 -0500
Subject: Re: oom goodness Re: 2.6.10-rc2-mm4
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Chris Ross <chris@tebibyte.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41B036DB.5060502@tebibyte.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <41B036DB.5060502@tebibyte.org>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 23:16:40 +0100
Message-Id: <1102112200.13353.274.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 10:50 +0100, Chris Ross wrote:
> Andrew Morton escreveu:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> 
> I hope I'm not tempting providence by reporting that this is the first 
> unpatched kernel in a while that seems free of the oom killer problems 
> I've been seeing. It's successfully handled all the usual trouble spots 
> (compiling umlsim, cron.daily etc.) on my 64MB machine without killing 
> off a single random process.

I can still see the problems I described detailed a couple of times :(

tglx


