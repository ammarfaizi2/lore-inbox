Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFAWMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFAWMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFAWJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:09:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:21211 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261324AbVFAWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:06:44 -0400
X-Authenticated: #428038
Date: Thu, 2 Jun 2005 00:06:41 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com,
       ltd@cisco.com, linux-kernel@vger.kernel.org, kraxel@suse.de,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601220641.GD31585@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, toon@hout.vanvergehaald.nl,
	mrmacman_g4@mac.com, ltd@cisco.com, linux-kernel@vger.kernel.org,
	kraxel@suse.de, dtor_core@ameritech.net, 7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <429DD036.nail7BF7MRZT6@burner> <20050601154245.GA14299@voodoo> <429DE874.nail7BFM1RBO2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DE874.nail7BFM1RBO2@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2005-06-01:

> Note that Linux did not have a usable /dev/whatever based interface 10 years ago.
> Also note that cdda2wav distinguishes between "OS native Audio ioctl calls" and
> generic SCSI from checking the dev= parameter. For this reason using 
> /dev/whateter is just wrong.

Now this is an implementation detail of your application, and the OS
abstraction inside your application might well use a smarter way of
figuring out if it's a SCSI interface or not.

-- 
Matthias Andree
