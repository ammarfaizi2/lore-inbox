Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTJRV2z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJRV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:28:55 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:5253 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261863AbTJRV2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:28:54 -0400
Date: Sat, 18 Oct 2003 23:28:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pavel@ucw.cz
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031018212833.GA28644@elf.ucw.cz>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston> <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston> <20031017111032.GB1639@casa.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017111032.GB1639@casa.fluido.as>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried those updates (over -test8, I downloaded .gz-version, and it
contained lots of files like include/asm/*, no problems patching,
through). Well, cursor problems only got worse.

VGA-softcursor problems are still there (backspace leaves ghost
cursors behind).

Cursor problems got *worse*. With vanilla, cursor got corrupted when
using gpm. Now it is *allways* corrupted :-(. I'm using vesafb.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
