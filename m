Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUDXRS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUDXRS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUDXRS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 13:18:28 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:27664 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S261300AbUDXRS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 13:18:27 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: standart events for hotkeys?
Date: Sat, 24 Apr 2004 19:18:22 +0200
User-Agent: KMail/1.6
References: <200404200042.24671.cijoml@volny.cz> <200404241900.28907.cijoml@volny.cz> <200404242014.15525.kim@holviala.com>
In-Reply-To: <200404242014.15525.kim@holviala.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404241918.22817.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 of April 2004 19:14, you wrote:
> On Saturday 24 April 2004 20:00, Michal Semler wrote:
> > > > Does any standart exist for hotkeys and their returned events?
> > >
> > > I believe vojtech already has codes assigned to keys like those.
> >
> > Hmmm and all the drivers has to use them?
>
> Just to clear some confusion: the event interface has keycodes assigned for
> nearly everything (thanks to Vojtech) so that's not the problem. The
> problem is that a Email key on a Dell is different from an Email key on
> Microsoft keyboard. There's no standard so it's REALLY difficult to support
> those apart from collecting info about hundreds of different keyboards and
> their hotkeys.

yes,

and this is what I mean. We should start project collecting this. As PCI cards 
list for example.

That is my opinion. And yours?

Michal
