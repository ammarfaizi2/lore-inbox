Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUEaMHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUEaMHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 08:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUEaMHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 08:07:43 -0400
Received: from styx.suse.cz ([82.208.2.94]:23936 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264270AbUEaMHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 08:07:42 -0400
Date: Mon, 31 May 2004 14:08:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch - please comment] Support for UTF dead keys in 2.6
Message-ID: <20040531120844.GA1655@ucw.cz>
References: <20040529143421.GA15127@ucw.cz> <200405310809.49059.ioe-lkml@rameria.de> <20040531063149.GD268@ucw.cz> <200405311123.07203.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405311123.07203.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 11:23:02AM +0200, Ingo Oeser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Vojtech,
> 
> On Monday 31 May 2004 08:31, you wrote:
> > > > ChangeSet@1.1610, 2004-05-03 12:38:37+02:00, vojtech@suse.cz
> > > >   input: Make accent tables able to generate unicode characters. This
> > > >          is needed for UTF8 console with multi-keystroke characters.
> >
> > Did you want to say anything?
> 
> Yes,
> 	1. My external editor setup was broken (kvim + kmail). Sorry
> 	   for this.
> 
> 	2. Does your patch also support 2 diacritics per character?
> 	   This is a requirement for proper Vietnamese support.

No, the patch doesn't add that extension. How is that supposed to work?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
