Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUBKWnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUBKWnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:43:02 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:9484 "EHLO prin.lo2.opole.pl")
	by vger.kernel.org with ESMTP id S266215AbUBKWnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:43:00 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.2.0
Date: Wed, 11 Feb 2004 23:39:55 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200402112339.55593.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at: http://ep09.pld-linux.org/~mmazur/linux-libc-headers/

Changes:
- applied changes from 2.6.2 kernel
- added an empty linux/compiler.h (I really hate myself for doing this, but 
don't have much choice... many apps include it as a workaround for broken 
headers that come with linux)
- some minor changes... mostly removing duplicate definitons and replacing 
them with calls to glibc's headers

Enjoy.

-- 
Ka¿dy cz³owiek, który naprawdê ¿yje, nie ma charakteru, nie mo¿e go mieæ.
Charakter jest zawsze martwy, otacza ciê zgni³a struktura przeniesiona z 
przesz³o¶ci. Je¿eli dzia³asz zgodnie z charakterem wtedy nie dzia³asz w ogóle
- jedynie mechanicznie reagujesz.                 { Osho }
