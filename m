Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUDXRBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUDXRBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDXRBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 13:01:00 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:32772 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S262468AbUDXRAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 13:00:33 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: standart events for hotkeys?
Date: Sat, 24 Apr 2004 19:00:28 +0200
User-Agent: KMail/1.6
References: <200404200042.24671.cijoml@volny.cz> <20040420193449.GE1413@openzaurus.ucw.cz>
In-Reply-To: <20040420193449.GE1413@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404241900.28907.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 of April 2004 21:34, you wrote:
> Hi!
>
> > I have a question related to keyboard and hotkeys.
> >
> > Does any standart exist for hotkeys and their returned events?
> > I have 2 keyboards with hotkeys, one on laptop (acerhk operated) and one
> > wireless (BlueZ bthid operated) and both returns different codes in xev
> > when same keys are pressed
> >
> > mail
> > browser
> > etc.
>
> I believe vojtech already has codes assigned to keys like those.
> 				Pavel

Hmmm and all the drivers has to use them?

Michal
