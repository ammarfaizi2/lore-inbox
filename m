Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRAaQoe>; Wed, 31 Jan 2001 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAaQoQ>; Wed, 31 Jan 2001 11:44:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24308 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130781AbRAaQnz>;
	Wed, 31 Jan 2001 11:43:55 -0500
Date: Wed, 31 Jan 2001 17:43:38 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101311643.RAA16328.aeb@vlet.cwi.nl>
To: andre@linux-ide.org, mlord@pobox.com, ole@linpro.no
Subject: Re: Problems with Promise IDE controller under 2.4.1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ole Aamot writes:

	We experience trouble with the Promise (PDC20265) IDE controller
	and seven 75GB IBM disks on a single CPU (Pentium-III) server.

	Linux 2.4.1 fails to detect correct geometry for the four last
	disks (identified as hde, hdf, hdg, hdh).

But there is no indication of what the problems could be,
or what he thinks the geometry should be (and why).
I see nothing very wrong in the posted data.

Andries


[Don't forget: (i) geometry does not exist (ii) hdparm is just
some user program.]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
