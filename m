Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVGFNBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVGFNBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVGFNBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 09:01:39 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:48586 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S262209AbVGFJik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:38:40 -0400
Message-ID: <42CBA650.8080004@eyal.emu.id.au>
Date: Wed, 06 Jul 2005 19:37:20 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  sound/pci/bt87x.o
sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
sound/pci/bt87x.c:807: error: for each function it appears in.)
sound/pci/bt87x.c: At top level:
sound/pci/bt87x.c:910: error: `driver' used prior to declaration

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
