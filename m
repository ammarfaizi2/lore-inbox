Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSA2Gue>; Tue, 29 Jan 2002 01:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSA2GuX>; Tue, 29 Jan 2002 01:50:23 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:18318 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288859AbSA2GuP>; Tue, 29 Jan 2002 01:50:15 -0500
Date: Tue, 29 Jan 2002 08:45:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Mark Zealey <mark@zealos.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <20020128182427.11F20FB8D@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201290838560.20095-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> MTRR, of course (do you like 2D and even 3D hardware accelerated without 
> MTRR?), FB, no, chipset is a AMD 750 (Irongate C4), using X 4.1.99.1 DRI CVS.

The reason why i ask is because i was experiencing font corruption with 
MTRRs enabled and X segfaulting with 4.x and a VIA Apollo pro (mostly 
because with 3.3.6 i never setup the MTRRs myself) and a friend of mine was
seeing corruption plus the occasional lockup with his KT133. Disabling MTRRs
solved both our lockup problems, mind you i soon switched back to my older
440BX setup and my problems went away. I also asked about FB because my particular card 
(ATI Rage IIC) never gets MTRRs working in X4.1 unless i have it FB 
enabled.

Regards,
	Zwane Mwaikambo


