Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272694AbRHaOCk>; Fri, 31 Aug 2001 10:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272697AbRHaOC3>; Fri, 31 Aug 2001 10:02:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24585 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272694AbRHaOCV>; Fri, 31 Aug 2001 10:02:21 -0400
Subject: Re: Linux 2.4.9-ac5
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Fri, 31 Aug 2001 15:05:30 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), alan@lxorguk.ukuu.org.uk (Alan Cox),
        laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200108310543.f7V5h3S452102@saturn.cs.uml.edu> from "Albert D. Cahalan" at Aug 31, 2001 01:43:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15covL-0003G0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The LGPL, X11, and 2-clause BSD licenses shouldn't set the tainted flag.
> Perhaps the licenses should simply be listed.

2 clause BSD isnt neccessarily as free. For the cases where it is thats why
I stuck in "GPL with additional..."

The reason for keeping specific exact strings is to avoid the old
"GPL license sucks this is nonfree" type approach to tricking tools
