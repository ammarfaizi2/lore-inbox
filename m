Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKIQX3>; Thu, 9 Nov 2000 11:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbQKIQXT>; Thu, 9 Nov 2000 11:23:19 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:35850
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129076AbQKIQXF>; Thu, 9 Nov 2000 11:23:05 -0500
Date: Thu, 9 Nov 2000 11:33:47 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109113347.B14133@animx.eu.org>
In-Reply-To: <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <3A0977A7.53641C52@mandrakesoft.com> <20001108113859.A10997@animx.eu.org> <3A098594.A85DFE0D@mandrakesoft.com> <20001108122306.A11107@animx.eu.org> <3A0989CC.2537FCEA@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3A0989CC.2537FCEA@mandrakesoft.com>; from Jeff Garzik on Wed, Nov 08, 2000 at 12:13:48PM -0500
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
