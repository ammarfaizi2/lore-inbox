Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLEWPq>; Tue, 5 Dec 2000 17:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLEWPh>; Tue, 5 Dec 2000 17:15:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8452 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129511AbQLEWPX>; Tue, 5 Dec 2000 17:15:23 -0500
Subject: Re: 2.4.0-test12-pre5 breaks vmware (again)
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Tue, 5 Dec 2000 21:46:41 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian), linux-kernel@vger.kernel.org
In-Reply-To: <ECC703608DB@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Dec 05, 2000 01:54:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143Pv8-0000A9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > presumably already changed all their software to use 'features' (I did,
> > for example) and forgot about the old 'flags' forever....
> 
> Blessed vmware-config.pl contains
> 
> \(flags\|features\).*
> 
> so it should run...

vmware-config as used by the other 99.9999% of people does not

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
