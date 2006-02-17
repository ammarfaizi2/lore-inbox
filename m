Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWBQNkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWBQNkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWBQNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:40:24 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:61829 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S964912AbWBQNkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:40:22 -0500
Date: Fri, 17 Feb 2006 14:40:22 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060217.133041.10720.albireo@ucw.cz>
References: <43EB7BBA.nailIFG412CGY@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner> <mj+md-20060217.115403.7981.albireo@ucw.cz> <43F5CE2D.nail31P31133A@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5CE2D.nail31P31133A@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I encourage you to read the previous mails, this has been explained for more 
> than ten times now.....

Maybe the problem lies in nobody except you considering it an explanation.

E.g., your theory about Linux breaking POSIX has been disproved pretty quickly.

Feel free to consider the Linux interface silly or badly designed, that's
everybody's right, but please keep in mind that as long as you are unable to point
to any *real* problems with it, it's just your opinion not shared by most of
the other people, including the maintainers of the said subsystems, so it's
hardly a reason for changing the interface.

Sorry, but although I value your experience with CD writing very much,
I don't think you are the right person to decide on what the naming of devices
in Linux will look like, exactly because it's a problem with much broader
context than just SCSI devices.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"God doesn't play dice."   -- Albert Einstein
