Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWA0Nj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWA0Nj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWA0Nj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:39:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31149 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750987AbWA0Nj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:39:57 -0500
Date: Fri, 27 Jan 2006 13:39:39 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-ID: <20060127133939.GU27946@ftp.linux.org.uk>
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D9F9F9.5060501@ti-wmc.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:46:17AM +0100, Simon Oosthoek wrote:
> Linus Torvalds wrote:
> >The Linux kernel is under the GPL version 2. Not anything else. Some
> > individual files are licenceable under v3, but not the kernel in
> >general.
> 
> I believe that if v2 and v3 turn out to be incompatible, it would be
> quite hard to rationalise v3+ licensed files inside the kernel. So when
> people want their code to be in the kernel and still be v3+ compatible,
> they should probably dual license it, or include a specific section
> saying that the code can be licensed under v2 only if in the context of
> the Linux kernel.

Bzzert.   "GPLv2 only in the context of the Linux kernel" is incompatible
with GPLv2 and means that resulting kernel is impossible to distribute.
