Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVCWPE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVCWPE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCWPE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:04:58 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:6413 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261494AbVCWPE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:04:56 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
	 <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 16:04:54 +0100
Message-Id: <1111590294.27969.114.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 15:43 +0100, Jan Engelhardt wrote:
> >brings down almost all linux distro's while other *nixes survives.
> 
> Let's see if this can be confirmed.

open/free/netbsd survives. I guess OSX does too.

Gentoo (non-hardened), Red Hat, Mandrake, FC2 are vulnerable.

Debian stable survives but they set the default proc limit to 256. Looks
like Suse also is not vulerable. (I wonder if the daemons started from
booscripts are vulnerable though)

Solaris 10 seems to be vulnerable.

http://www.securityfocus.com/columnists/308

I think it would be nice if Linux could be mentioned together with the
*bsd's instead of the commercial *nixes next time :)

--
Natananael Copa


