Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRKVOl3>; Thu, 22 Nov 2001 09:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279722AbRKVOlT>; Thu, 22 Nov 2001 09:41:19 -0500
Received: from elin.scali.no ([62.70.89.10]:26886 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S279739AbRKVOlM>;
	Thu, 22 Nov 2001 09:41:12 -0500
Subject: Re: [Q] was the SYSENTER/SYSCALL fast system calls completed or
	discared in the end??
From: Terje Eggestad <terje.eggestad@scali.no>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011121225402.A175@elf.ucw.cz>
In-Reply-To: <1006184327.19902.2.camel@pc-16.office.scali.no> 
	<20011121225402.A175@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 22 Nov 2001 15:41:09 +0100
Message-Id: <1006440069.22598.4.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 2001-11-21 kl. 22:54 skrev Pavel Machek:
> 
> On Mon 19-11-01 16:38:45, Terje Eggestad wrote:
> > subject says it all....
> > 
> > I remember there was a discussion and a patch floating around that 
> > implemented SYSCALL/SYSRET, just want to know what happened to it....
> 
> discarded

Because there was no perf benefit  or because the patch was in poor
quality?


> 
> -- 
> <sig in construction>
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

