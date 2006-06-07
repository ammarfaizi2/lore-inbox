Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWFGOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWFGOXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWFGOXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:23:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50144 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932221AbWFGOXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:23:02 -0400
Date: Wed, 7 Jun 2006 16:22:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jvbest@qv3pluto.leidenuniv.nl, 100.30936@germany.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: NI5010 network driver -- MAINTAINERS entry
Message-ID: <20060607142213.GA3618@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


...is quite inconsistent with rest of file:

NI5010 NETWORK DRIVER
P:      Jan-Pascal van Best and Andreas Mohr
M:      Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
M:      Andreas Mohr <100.30936@germany.net>
L:      netdev@vger.kernel.org
S:      Maintained

probably should be

NI5010 NETWORK DRIVER
P:      Jan-Pascal van Best
M:      jvbest@qv3pluto.leidenuniv.nl
P:	Andreas Mohr
M:      100.30936@germany.net
L:      netdev@vger.kernel.org
S:      Maintained

...yes, "new" mail address format makes sense, but I guess whole file
should be converted.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
