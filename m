Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJLPzl>; Sat, 12 Oct 2002 11:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSJLPzl>; Sat, 12 Oct 2002 11:55:41 -0400
Received: from www.wireboard.com ([216.151.155.101]:62080 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S261277AbSJLPzk>; Sat, 12 Oct 2002 11:55:40 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: Michael.Abshoff@mathematik.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: How does ide-scsi get loaded?
References: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st>
	<200210121533.12998.alan@chandlerfamily.org.uk>
	<3DA8342C.40408@mathematik.uni-dortmund.de>
	<200210121555.19492.alan@chandlerfamily.org.uk>
From: Doug McNaught <doug@mcnaught.org>
Date: 12 Oct 2002 12:01:19 -0400
In-Reply-To: Alan Chandler's message of "Sat, 12 Oct 2002 15:55:09 +0100"
Message-ID: <m37kgn3auo.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> so isn't /etc/lilo.conf in /etc.
> 
> I keep saying - the string ide-scsi is not used anywhere in /etc
> 
> [and believe me, I have also looked manually at all these sorts of places]

Why not wrap /sbin/modprobe in a script that logs the module name to
the console?

-Doug
