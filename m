Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVCCBOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVCCBOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCBLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:11:09 -0500
Received: from [213.188.213.77] ([213.188.213.77]:26775 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S261336AbVCCBGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:06:25 -0500
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel release numbering
Date: Thu, 3 Mar 2005 02:04:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcUfeR0eVyiJ0gHERv+WGuqv4kaRKgAEeSWA
Message-Id: <20050303010615.3C7F184008@server1.navynet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Namely that we could adopt the even/odd numbering scheme that 
> we used to do on a minor number basis, and instead of 
> dropping it entirely like we did, we could have just moved it 
> to the release number, as an indication of what was the 
> intent of the release.

> Comments?

This is surely a good idea because end users (not developers) like me would
have greater possibility not to occur in a regression with an even release.

The real solution to the problem of having a really stable kernel is, IMHO,
to have a wide base of testers.
Usually, following a new stable release announce, lots of bugs get out
because people starts using the new kernel, just because they didn't try any
of the previous -RC releases.

So, why moving from 2.6.14 to 2.6.15 when, in 2/4 weeks, i'll have a more
stable 2.6.16 ? 
Will users help testing an odd release to have a good even release ? Or will
they consider an even release as important as a -RC release ?

My thought is that the community should do some marketing on the actual
developing model to obtain a wider testing base, or, with the new proposed
model, let people know that their help is necessary to have a stable kernel
and they should download, compile and install odd releases.

Sincerely,
 
 Massimo Cetra








