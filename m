Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292428AbSBPQu5>; Sat, 16 Feb 2002 11:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292431AbSBPQut>; Sat, 16 Feb 2002 11:50:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292428AbSBPQuk>;
	Sat, 16 Feb 2002 11:50:40 -0500
Message-ID: <3C6E8DDE.F0C33227@mandrakesoft.com>
Date: Sat, 16 Feb 2002 11:50:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: esr@thyrsus.com, Dave Jones <davej@suse.de>, Robert Love <rml@tech9.net>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <E16c7rR-0006Z5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Jeff and Alan have put their finger neatly on one of the key bits CML2
> > can do that CML1 cannot -- express cross-directory dependencies in
> > such a way that the configurator can force side effects in both
> > directions.  This is, in fact, the very rock on which my original
> > attempt to save CML1 foundered after six weeks of effort.
> 
> You can force a side effect in both directions.

Yup, good point.

I mentioned "requires" as a way of avoiding 'both directions' in some
cases.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
