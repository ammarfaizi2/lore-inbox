Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRKTWGg>; Tue, 20 Nov 2001 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281415AbRKTWG1>; Tue, 20 Nov 2001 17:06:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47491 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281410AbRKTWGW>; Tue, 20 Nov 2001 17:06:22 -0500
Date: Tue, 20 Nov 2001 17:04:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dale Amon <amon@vnl.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
In-Reply-To: <20011120220206.E22590@vnl.com>
Message-ID: <Pine.LNX.3.95.1011120170119.15039A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Dale Amon wrote:

> On Tue, Nov 20, 2001 at 09:49:01PM +0000, David Woodhouse wrote:
> 
> > insmod dummy
> > ip link set dummy0 name eth0
> > ip link set eth0 address 01:02:03:04:05:06
> 
> Ewwwww... that's totally evyul. I love it.

Yep! Just don't use ff:ff:ff:ff:ff:ff if you don't want your CPU
to melt down. I'm told you get all the data in the universe, almost
as bad as NETbeui  ;^)

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


