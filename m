Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSFOWl6>; Sat, 15 Jun 2002 18:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSFOWl4>; Sat, 15 Jun 2002 18:41:56 -0400
Received: from waste.org ([209.173.204.2]:20404 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315709AbSFOWlm>;
	Sat, 15 Jun 2002 18:41:42 -0400
Date: Sat, 15 Jun 2002 17:41:28 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
In-Reply-To: <Pine.LNX.4.44.0206151110140.5254-100000@alumno.inacap.cl>
Message-ID: <Pine.LNX.4.44.0206151739270.26335-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Robinson Maureira Castillo wrote:

> On Sat, 15 Jun 2002, Zwane Mwaikambo wrote:
> >
> > And when this gets to mainline, what stops your hacker from removing the
> > printk from displaying? The way i see it, if the person is loading modules
> > you're screwed beyond help.
> >
>
> That's why I was asking for a better place to put this printk,

The better place is before the attacker gets root access. After that, all
bets are off.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

