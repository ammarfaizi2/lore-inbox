Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285186AbSACJcN>; Thu, 3 Jan 2002 04:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285188AbSACJcE>; Thu, 3 Jan 2002 04:32:04 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:11512 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285186AbSACJbt>; Thu, 3 Jan 2002 04:31:49 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020103041244.D6936@thyrsus.com> 
In-Reply-To: <20020103041244.D6936@thyrsus.com>  <20020103040301.A6936@thyrsus.com> <20020102211038.C21788@thyrsus.com> <20020102174824.A21408@thyrsus.com> <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de> <20020102211038.C21788@thyrsus.com> <3021.1010048894@redhat.com> <20020103040301.A6936@thyrsus.com> <4658.1010049555@redhat.com> 
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 09:31:34 +0000
Message-ID: <6364.1010050294@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> > Making it _easier_ for Aunt Tillie to install something like 2.4.10 is
> > not necessarily doing her a favour.

> But making it unnecessarily harder is *certainly* not a favor.

Making it _gratuitously_ harder isn't called for, true - but it's definitely
not a case we need to _optimise_ for.

I'm surprised you feel the need to do it, but I'll not try and stop you - as
long as in doing so you don't make it more difficult for the people who _do_
actually do this all day every day.

--
dwmw2


