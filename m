Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUAWSKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUAWSKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:10:00 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:35597 "EHLO
	prin.lo2.opole.pl") by vger.kernel.org with ESMTP id S262902AbUAWSJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:09:59 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Userland headers available
Date: Fri, 23 Jan 2004 19:07:17 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401231907.17802.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At http://ep09.pld-linux.org/~mmazur/glibc-kernel-headers/ there are userland 
headers for linux, derived from 2.6 kernels with lots of 2.4 compatibility 
fixes. CVS repo can be found at cvs.pld-linux.org/glibc-kernel-headers (anon 
and webcvs). These headers are currently used to compile a whole linux distro 
(ftp.pld-linux.org/dists/ac) for x86, sparc, amd64, alpha and ppc, but 
general fixes are applied to all archs since we never know if a new arch 
won't be added (amd64 was added just a month-two ago). #1 feature is that 
they are and will be maintained (currently three people are working on them) 
and bugs are mostly fixed instantly. Enjoy.


-- 
Ka¿dy cz³owiek, który naprawdê ¿yje, nie ma charakteru, nie mo¿e go mieæ.
Charakter jest zawsze martwy, otacza ciê zgni³a struktura przeniesiona z 
przesz³o¶ci. Je¿eli dzia³asz zgodnie z charakterem wtedy nie dzia³asz w ogóle
- jedynie mechanicznie reagujesz.                 { Osho }
