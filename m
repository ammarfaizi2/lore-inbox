Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWA0HeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWA0HeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWA0HeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:34:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21939 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932423AbWA0HeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:34:17 -0500
Subject: RE: GPL V3 and Linux - Dead Copyright Holders
From: Arjan van de Ven <arjan@infradead.org>
To: davids@webmaster.com
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEBHJLAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKKEBHJLAB.davids@webmaster.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 08:34:11 +0100
Message-Id: <1138347252.3058.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 18:15 -0800, David Schwartz wrote:
> > Linus is posturing. I can go back to numerous previous versions when he
> > and stallman were "buddy buddy" and the language was open
> > and said "any later version". Well, here's the gotcha. Any version
> > released before Linus said this is GPL 2, 3 or later. As of today, all new
> > versions are GPLv2. That's how the law works. So 2.6.15 forward is GPLv2
> > only. Linus cannot re-release previous Linux versions after he
> > already posted this NOTICE in COPYING, which he did and left the
> > language pen like this. So it's up to the recevier of the code whether
> > its GPLv2 or GPLv3 or whatever, but those releases which appeared with
> > COPYING stating this language are whatever GPL license you
> > want.
> >
> > Jeff
> 
> 	Linus can't put additional restrictions on code he didn't write. If the
> authors licensed it under the GPL version 2 and "any later version", Linus

you use the word "AND". Everyone else uses the word "OR". The word OR
means you have a choice, basically the code is dual licensed with GPLv2
and "any later version", and you can pick whichever one you want.
However if you combine it with the kernel, the v2 is chosen for you,
just by virtue of the license of the code that is v2-only. Eg: dual
licensed code in the kernel automatically picks the GPLv2 side.


If the wording was "AND", you would be right, but then both licenses
would have to apply at the same time, which gets really nasty if there
are conflicts between them (and it looks like there are)

