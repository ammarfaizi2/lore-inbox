Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133095AbRDRMIc>; Wed, 18 Apr 2001 08:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133096AbRDRMIV>; Wed, 18 Apr 2001 08:08:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133095AbRDRMIM>; Wed, 18 Apr 2001 08:08:12 -0400
Subject: Re: Let init know user wants to shutdown
To: chief@bandits.org (John Fremlin)
Date: Wed, 18 Apr 2001 12:55:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        andrew.grover@intel.com (Grover Andrew),
        linux-power@phobos.fachschaften.tu-muenchen.de ("Acpi-PM (E-mail)"),
        pavel@suse.cz ('Pavel Machek'),
        Simon.Richter@phobos.fachschaften.tu-muenchen.de (Simon Richter),
        aferber@techfak.uni-bielefeld.de (Andreas Ferber),
        linux-kernel@vger.kernel.org
In-Reply-To: <m2k84jkm1j.fsf@boreas.yi.org.> from "John Fremlin" at Apr 18, 2001 02:56:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pqYS-0004Y3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wondering if that veto business is really needed. Why not reject
> *all* APM rejectable events, and then let the userspace event handler
> send the system to sleep or turn it off? Anybody au fait with the APM
> spec?

Because apmd is optional
