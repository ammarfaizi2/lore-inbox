Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTBBSW3>; Sun, 2 Feb 2003 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTBBSW2>; Sun, 2 Feb 2003 13:22:28 -0500
Received: from mail.ithnet.com ([217.64.64.8]:35856 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265469AbTBBSW1>;
	Sun, 2 Feb 2003 13:22:27 -0500
Date: Sun, 2 Feb 2003 19:31:44 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: tg3 driver problems with shared interrupts
Message-Id: <20030202193144.4138d80d.skraw@ithnet.com>
In-Reply-To: <3E3D6367.9090907@pobox.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 13:28:55 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephan von Krawczynski wrote:
> > On Sun, 02 Feb 2003 11:49:12 -0500
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >>Can you try two things?
> >>
> >>1) 2.4.21-pre4 + tg3 v1.4
> > 
> > 
> > Ok. With the latest version you sent I got it compiled and working. As far as I
> > can tell from short tests it looks good (eth2 is tg3):
> 
> cool beans, thanks!
> 
> 
> > To make sure I will let it stress-test overnight and send you the results in
> > about 15 hours from now on. If everything does fine I will redo with ide2,ide3
> > on same interrupt, too. Just to see what happens with these Promise things...
> 
> 
> great.
> 
> though who knows with the Promise stuff... :)  I hope it's not their 
> binary-only junk...

I am using "PROMISE PDC202{68|69|70|71|75|76|77} support" from standard kernel.

-- 
Regards,
Stephan

