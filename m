Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279587AbRJXUSA>; Wed, 24 Oct 2001 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279583AbRJXURt>; Wed, 24 Oct 2001 16:17:49 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:54026 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S279587AbRJXURk>;
	Wed, 24 Oct 2001 16:17:40 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110242018.f9OKI6000908@oboe.it.uc3m.es>
Subject: Re: status of supermount?
In-Reply-To: <20011024200049.A20340@niksula.hut.fi> from "Jonas Berlin" at "Oct
 24, 2001 08:00:49 pm"
To: "Jonas Berlin" <jonas@berlin.vg>
Date: Wed, 24 Oct 2001 22:18:06 +0200 (MET DST)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jonas Berlin wrote:"
> > Does anyone know if supermount has been ported to a more recent
> > kernel by anyone? The last version of supermount I could find
> > was for 2.4.0
> 
> I mailed the same question to the maintainer over six months ago but didn't
> get any answer. So I upgraded the patch myself to work with versions 2.4.2,
> 2.4.4 and 2.4.5. At some point I switched to using 2.4.4-ac9, which I am
> still using without problems, but I didn't have time back then to port the
> patch to that version.
> 

I have a patch dated Jan 14 17:09:06 2001. Does that match any of
yours?

  diff -rNu --exclude-from=exclude linux-2.4.vanilla/drivers/cdrom/cdrom.c linux-2.4/drivers/cdrom/cdrom.c
  --- linux-2.4.vanilla/drivers/cdrom/cdrom.c     Sun Jan 14 17:09:06
  2001
  +++ linux-2.4/drivers/cdrom/cdrom.c     Sun Jan 14 17:28:04 2001

Let me have your patch anyway. I want to examine the supermount
patches. I'll send you the one I have if you want it.

Peter
