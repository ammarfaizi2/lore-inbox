Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbSJEQLy>; Sat, 5 Oct 2002 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbSJEQLy>; Sat, 5 Oct 2002 12:11:54 -0400
Received: from traven.uol.com.br ([200.221.4.39]:4493 "EHLO traven.uol.com.br")
	by vger.kernel.org with ESMTP id <S262400AbSJEQLw>;
	Sat, 5 Oct 2002 12:11:52 -0400
Date: Sat, 5 Oct 2002 13:18:23 -0200
From: Andre Costa <brblueser@uol.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE subsystem issues with 2.4.1[89] [REVISITED]
Message-Id: <20021005131823.676c1bcc.brblueser@uol.com.br>
In-Reply-To: <1033833579.4103.2.camel@irongate.swansea.linux.org.uk>
References: <20021005114725.3af9c194.brblueser@uol.com.br>
	<1033833579.4103.2.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, thks for replying.

So, this basically means 2.4.20 final will contain all improvements on
the -ac branch plus the critical backports from 2.5.x? Will this be the
cure to all my probls? ;)

Seriously speaking: do you have confirmartion that the IDE updates on
the -ac branch fix the cd audio ripping timeouts? Do you want me to try
it out? <newbie>If so, can I simply apply the 2.4.20-pre8-ac3 on top of
my vanilla 2.4.19 source code or is any other patch required?</newbie>

Again, thks for looking into this.

Best,

Andre

On 05 Oct 2002 16:59:39 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sat, 2002-10-05 at 14:47, Andre Costa wrote:
> > I know this is a known issue, and you guys are working on it; I also
> > know many changes to IDE subsystem have been backported from 2.5.x
> > series, and 2.4.20pre* already reflect some (all?) of them. I don't
> > want to rush things, I was just curious to know the current status
> > regarding these IDE issues.
> 
> 2.5 has most but not all of the IDE updates in 2.4-ac. 2.4 vanilla has
> basically old IDE code but with some small PCI layer fixes backported
> that deal with all the i845G bios mess
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Andre Oliveira da Costa
