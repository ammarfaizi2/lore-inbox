Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286220AbRLJKse>; Mon, 10 Dec 2001 05:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbRLJKsO>; Mon, 10 Dec 2001 05:48:14 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:12042 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S286220AbRLJKsE>; Mon, 10 Dec 2001 05:48:04 -0500
Date: Mon, 10 Dec 2001 11:46:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <000701c18148$f907f040$21c9ca95@mow.siemens.ru>
Message-ID: <Pine.LNX.4.33.0112101140330.25406-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Dec 2001, Borsenkow Andrej wrote:

> > Which is still included in the kernel tree and at least Mandrake is
> > currently using it.
>
> Which resulted in weird problems like floating device numbers, broken
> links in /dev/cdroms, mysteriously disappearing sound nodes ...

I can imagine it's not without problems, but...

> I very much appreciate this decision. Copying over device nodes is evil.
> It should be stopped by all means (as long as devfs is going to be
> used).

it should not suddenly break for anyone still using it, warning messages
are fine.

bye, Roman

