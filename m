Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRDHNKZ>; Sun, 8 Apr 2001 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDHNKQ>; Sun, 8 Apr 2001 09:10:16 -0400
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:48645 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S132550AbRDHNKM>;
	Sun, 8 Apr 2001 09:10:12 -0400
Date: Sun, 8 Apr 2001 08:10:05 -0500 (CDT)
From: Thomas Molina <tmolina@home.com>
To: =?iso-8859-1?q?Fran=E7ois=20Dupoux?= <fdupoux@free.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem when booting 2.4.3 from a floppy disk
In-Reply-To: <01040713471000.00368@fdupoux.org>
Message-ID: <Pine.LNX.4.30.0104080802500.7236-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Apr 2001, François Dupoux wrote:

> Hi,
>
> I have a strange bug when trying to boot a kernel-2.4.3 (official release)
> from an 1.44 MB floppy disk. Just after the "Loading...........", there is an
> infinite loop, and this message is printed:
> 0200
> AX: 0212
> BX: BC00
> CX: 5101
> DX: 0000
> 0200
> AX: 0212
> BX: BC00
> CX: 5101
> DX: 0000
> ....

Do you have any suspect hardware in your system?  The reason I ask is
that I have a part time job working in a computer shop where I build and
repair ix86 systems.  I've seen this occasionally when I use a 2.4.X
boot floppy to diagnose system problems.  It hasn't been consistent and
it hasn't happened often enough to correlate with anything else.

I've resolved to keep formal statistics on systems which exhibit this
problem so I would appreciate a cc on any followups to this.

