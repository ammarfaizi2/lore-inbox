Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSCGAaX>; Wed, 6 Mar 2002 19:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSCGAaN>; Wed, 6 Mar 2002 19:30:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288830AbSCGAaA>; Wed, 6 Mar 2002 19:30:00 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Thu, 7 Mar 2002 00:44:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard),
        linux-kernel@vger.kernel.org
In-Reply-To: <200203070028.TAA05380@ccure.karaya.com> from "Jeff Dike" at Mar 06, 2002 07:28:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16im12-0000Na-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer maps to fail when they make the total maps exceed the tmpfs limit.

That makes more sense and can be done yes. Probably it wants to be a tmpfs
option
