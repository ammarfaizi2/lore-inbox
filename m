Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272156AbRH3KKs>; Thu, 30 Aug 2001 06:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272157AbRH3KKi>; Thu, 30 Aug 2001 06:10:38 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:8713 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S272156AbRH3KKW>; Thu, 30 Aug 2001 06:10:22 -0400
Subject: smp freeze on 2.4.9
From: Philippe Amelant <philippe.amelant@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 30 Aug 2001 12:10:37 +0200
Message-Id: <999166237.1257.31.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have an ABIT BP6 mobo with 2 celeron 400 running redhat 7.1 with 2.4.3
SMP (from kernel.org not from redhat)
it works well.
But when i try to update my kernel, i always get a lockups in few
minutes. sometimes kernel just freeze when booting.
I have tried other kernel such as 2.4.5, 2.4.6 and 2.4.7 and I always
get the same result.
but if i compile a non SMP kernel the box is stable.
Is it a know problem ?
are there a work around ?

thanks

