Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbSAIMIl>; Wed, 9 Jan 2002 07:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSAIMIb>; Wed, 9 Jan 2002 07:08:31 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:54922
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S285134AbSAIMIZ>; Wed, 9 Jan 2002 07:08:25 -0500
Date: Wed, 9 Jan 2002 07:17:13 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Over usage of memory on 2.4.16
Message-ID: <20020109071713.A30562@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used to use 2.2.19 before going to 2.4.16 and I normally noticed I had
about 120mb of memory actually used and about 2-3mb in swap after weeks of
uptime.

This is what 2.4.16 looks like:
             total       used       free     shared    buffers     cached
Mem:        514248     487444      26804          0      35172     204360
-/+ buffers/cache:     247912     266336
Swap:       131048      44724      86324

Why is 2.4.16 using this much memory after only 5 days uptime?  I never saw
this much with 2.2.19 after 3 weeks of uptime.

I'm not running anything different than I normally do.  a few xterms, X
3.3.6, netscape 4.77, star office 5.2, and a bunch of daemons.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
