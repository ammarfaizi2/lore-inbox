Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277114AbRJQTp1>; Wed, 17 Oct 2001 15:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277115AbRJQTpR>; Wed, 17 Oct 2001 15:45:17 -0400
Received: from ns.caldera.de ([212.34.180.1]:47749 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277114AbRJQTpC>;
	Wed, 17 Oct 2001 15:45:02 -0400
Date: Wed, 17 Oct 2001 21:45:22 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] maintainers entry for personality handling
Message-ID: <20011017214522.A18316@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch adds myself to MATINAINERS for the personality
handling.  The code was orphaned for a long time and I did a rewrite
that got into 2.4.11.  I also maintain linux-abi, the patch to support
foreign personalities under i386 (more architectures to come).

If someone wants to take the role instead speak up NOW or remain silent
forever :)


	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


--- ../master/linux-2.4.13-pre3/MAINTAINERS	Wed Oct 17 00:33:22 2001
+++ linux-2.4.13-pre3/MAINTAINERS	Wed Oct 17 21:40:13 2001
@@ -1121,6 +1121,12 @@
 W:	http://www.torque.net/linux-pp.html
 S:	Maintained
 
+PERSONALITY HANDLING
+P:	Christoph Hellwig
+M:	hch@caldera.de
+L:	linux-abi-devel@lists.sourceforge.net
+S:	Supported
+
 PCI ID DATABASE
 P:	Jens Maurer
 M:	jmaurer@cck.uni-kl.de
