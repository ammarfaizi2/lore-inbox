Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129859AbQKWJrZ>; Thu, 23 Nov 2000 04:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129975AbQKWJrG>; Thu, 23 Nov 2000 04:47:06 -0500
Received: from styx.suse.cz ([195.70.145.226]:56311 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S129859AbQKWJrF>;
        Thu, 23 Nov 2000 04:47:05 -0500
Date: Thu, 23 Nov 2000 09:52:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: macro@ds2.pg.gda.pl, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
Message-ID: <20001123095223.A185@suse.cz>
In-Reply-To: <Pine.GSO.3.96.1001122175514.29041A-100000@delta.ds2.pg.gda.pl> <E13ye9w-0006FS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13ye9w-0006FS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 22, 2000 at 05:58:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 05:58:14PM +0000, Alan Cox wrote:

> > > 	if(vendor!=INTEL && !has_apic)
> > > 		/* No SMP */
> > 
> >  And suddenly certain i486 systems do not work anymore?  Well, I haven't
> 
> i486 is an intel processor

... but is there a reason why for example AMD 486's couldn't work in a
82489DX-based SMP board?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
