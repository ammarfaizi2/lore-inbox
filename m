Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSLINLG>; Mon, 9 Dec 2002 08:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSLINLG>; Mon, 9 Dec 2002 08:11:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:20524
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265320AbSLINLG>; Mon, 9 Dec 2002 08:11:06 -0500
Date: Mon, 9 Dec 2002 08:21:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.5.50
In-Reply-To: <200212091236.06966.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.50.0212090820250.2139-100000@montezuma.mastecende.com>
References: <200212091056.08860.roy@karlsbakk.net>
 <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
 <200212091236.06966.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:

> > Is this reproducible? If so without CONFIG_PREEMPT?
>
> I found it easily reproducable - I just did the same old 'make
> modules_install' from the kernel dir, and BUG. Witout CONFIG_PREEMPT,
> however, I was not, and I tried to stress it quite a bit

Unfortunately for you this currently falls under unsupported
configuration.

Cheers,
	Zwane
-- 
function.linuxpower.ca
