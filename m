Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSAWP7X>; Wed, 23 Jan 2002 10:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289886AbSAWP7N>; Wed, 23 Jan 2002 10:59:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46095 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289885AbSAWP7B>; Wed, 23 Jan 2002 10:59:01 -0500
Date: Wed, 23 Jan 2002 18:59:03 +0300
From: Oleg Drokin <green@namesys.com>
To: Joel Cordonnier <joel_linuxfr@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to mount root fs / reiserfs /HELP please
Message-ID: <20020123185903.A22603@namesys.com>
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 23, 2002 at 12:30:48PM +0100, Joel Cordonnier wrote:

> I compile and copy the LILO boot sector to a floppy
> disk. On my /boot partition of my Suse parition there
> is a reiserfs fs.
Recent LiLo versions can deal wih reiserfs. Also if you mount /boot with
-o notail option, and then write your kernel there, even old LiLo will work.
Alternatively you can store your kernel on floppy along with LiLo.

> I have read that reiserfs is not supported for a
> 'default' kernel and that i have to include
> patches...right `?
No.

Bye,
    Oleg
