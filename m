Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQKIQ0a>; Thu, 9 Nov 2000 11:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQKIQ0U>; Thu, 9 Nov 2000 11:26:20 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:37130
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129030AbQKIQ0C>; Thu, 9 Nov 2000 11:26:02 -0500
Date: Thu, 9 Nov 2000 11:36:47 -0500
From: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109113647.D14133@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was posted to lkml, so no link (except if you want to dig through
> lkml mail archives).

It booted but then it oops'ed before userland I belive.  I tried it this
morning and didn't have much time.  It did find the scsi controller (which
is across the bridge) and the drives attached so it does appear to be
working.  Maybe they can add that patch in for test11pre2 (or 3 if 2 is
already out)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
