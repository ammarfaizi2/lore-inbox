Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWAZWXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWAZWXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWAZWXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:23:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51386 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932327AbWAZWXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:23:50 -0500
Date: Thu, 26 Jan 2006 22:23:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Marc Perkel <marc@perkel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-ID: <20060126222333.GT27946@ftp.linux.org.uk>
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D94A4B.8060902@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D94A4B.8060902@perkel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 02:16:43PM -0800, Marc Perkel wrote:
> Just for clarification. What you are saying is that anyone who insists 
> on contributing to the kernel under GPLv3 - that code would be 
> prohibited from being included in the kernel? That to contribute to the 
> kernel you must contribute under the terms presently in place?

"terms compatible with those for code already in place".  Which is obviously
true for any project, since otherwise you end up with result that can not
be distributed at all.
