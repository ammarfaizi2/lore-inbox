Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbRCYOpq>; Sun, 25 Mar 2001 09:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131993AbRCYOpg>; Sun, 25 Mar 2001 09:45:36 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16134 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131990AbRCYOpP>; Sun, 25 Mar 2001 09:45:15 -0500
Message-ID: <3ABE017A.E7489DD7@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:32:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Benoit Garnier <bunch@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <00d801c0b4bb$e7a04be0$0201a8c0@cybercable.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Garnier wrote:
> 
> Szabolcs Szakacsits wrote :
> 
> > But if you start
> > to think you get the conclusion that process killing can't be avoided if
> > you want the system keep running.
> 
> What's the point in keeping the OS running if the applications are silently
> killed?
> 
> If your box is running for example a mail server, and it appears that
> another process is juste eating the free memory, do you really want to kill
> the mail server, just because it's the main process and consuming more
> memory and CPU than others?

Yes bloody dumn, becouse I can then go no to the box, blacklist
the smapper causing this with ipchains (or whatever it's called)
and restart sendmail - WITHOUT DRIVING 1900km.
