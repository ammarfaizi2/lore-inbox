Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVLAQWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLAQWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLAQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:22:04 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:47496 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbVLAQWC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:22:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eup88+F4Puis50/nVuseCzau5ucCXnC9q9E5cQDH7hGSF/0D4lUIRA2Eus3cpPMHS0Lmm9MvfFnT7krRG3E+qmItjHzz+ET0Scjs93JIAckWCYM02AbRchFvwFFn/fkiGoLpY+5QUkVITWf5ApfhyjHsBmSPRgJ0y0VLIqjakEU=
Message-ID: <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
Date: Thu, 1 Dec 2005 08:22:01 -0800
From: Ray Lee <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/43] ktimer reworked
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       george@mvista.com, johnstul@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0512011352590.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512010118200.1609@scrub.home>
	 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/05, Roman Zippel <zippel@linux-m68k.org> wrote:
> The human language is a bit more complicated than this (at least English
> and related languages). Depending on the context a word can have different
> meanings, e.g. if you ask an athlete what "timeout" means, you'll get a
> different answer than you would get from an engineer.

Actually, no you won't. The athlete will say "A timeout? Something out
of the ordinary happened, and coach wants me to go to the sidelines to
talk." Timeouts are unexpected and exceptional, whether you're an
athlete or a piece of code. On the other hand, they have a timer that
everyone *expects* to expire at the end of the quarter or game.

Ray, who is both an athlete and a native English speaker, who thinks
the naming is the clearest of anything to come across this list in
ages.
