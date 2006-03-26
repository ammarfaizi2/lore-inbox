Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCZM2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCZM2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWCZM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:28:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32410 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751307AbWCZM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:28:13 -0500
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 14:26:48 +0200
Message-Id: <1143376008.3064.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 06:52 -0500, Kyle Moffett wrote:
> On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > I'm working on some sample patches now which I'll try to post in a
> > few days if I get the time.
> 
> Ok, here's a sample of the KABI conversion and cleanup patches that I'm
> proposing.  I have a few fundamental goals for these patches:

is KABI the right name? I mean.. from the kernel pov it's the interface
to userspace ;)

