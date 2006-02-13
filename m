Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWBMOHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWBMOHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWBMOHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:07:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:410 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751779AbWBMOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:07:43 -0500
Date: Mon, 13 Feb 2006 15:07:42 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.140141.31817.atrey@ucw.cz>
References: <20060208162828.GA17534@voodoo> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner> <200602092221.56942.dhazelton@enter.net> <43F08C5F.nailKUSDKZUAZ@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F08C5F.nailKUSDKZUAZ@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> libscg abstracts from a kernel specific transport and allows to write OS 
> independent applications that rely in generic SCSI transport.
> 
> For this reason, it is bejond the scope of the Linux kernel team to decide on 
> this abstraction layer. The Linux kernel team just need to take the current
> libscg interface as given as _this_  _is_ the way to do best abstraction.

Do you really believe that libscg is the only way in the world how to
access SCSI devices?

How can you be so sure that the abstraction you have chosen is the only
possible one?

If an answer to either of this questions is NO, why do you insist on
everybody bending their rules to suit your model?

> The Linux kernel team has the freedom to boycott portable user space SCSI 
> applications or to support them.

That's really an interesting view ... if anybody is boycotting anybody,
then it's clearly you, because you refuse to extend libscg to support
the Linux model, although it's clearly possible.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Ctrl and Alt keys stuck -- press Del to continue.
