Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbTCSRhn>; Wed, 19 Mar 2003 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263094AbTCSRhm>; Wed, 19 Mar 2003 12:37:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29831 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263089AbTCSRhk>; Wed, 19 Mar 2003 12:37:40 -0500
Date: Wed, 19 Mar 2003 12:50:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Jasen <jjasen@realityfailure.org>
cc: "Richard B. Johnson" <johnson@quark.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Everything gone!
In-Reply-To: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
Message-ID: <Pine.LNX.4.53.0303191247420.32112@chaos>
References: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, John Jasen wrote:

> On Wed, 19 Mar 2003, Richard B. Johnson wrote:
>
> > Really? How did you do this?
> > Clone my machine-name and domain, I mean? Without -bs in the
> > header? I need to know. This could be exploited and needs
> > to be fixed.
>
> Perhaps:
>
> telnet target.system 25
> enter SMTP commands
> quit

Ah yes! And I just tried it! The target system was the one
that the mail was pretended to come from and it has sendmail
running and will forward from within the domain. So, that
sendmail gets a mail message as though it came directly from
itself so it will forward it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

