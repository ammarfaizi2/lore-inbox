Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSLXXma>; Tue, 24 Dec 2002 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSLXXma>; Tue, 24 Dec 2002 18:42:30 -0500
Received: from gandalf.tausq.org ([64.81.244.94]:7554 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id <S265987AbSLXXm3>;
	Tue, 24 Dec 2002 18:42:29 -0500
Date: Tue, 24 Dec 2002 15:51:47 -0800
From: Randolph Chung <randolph@tausq.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: parisc-linux@parisc-linux.org,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [parisc-linux] Generic RTC driver in 2.4.x?
Message-ID: <20021224235147.GT19331@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
References: <Pine.GSO.4.21.0212241451450.1821-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0212241451450.1821-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
X-PGP: for PGP key, see http://www.tausq.org/pgp.txt
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIK the generic RTC driver is used on PA-RISC, PPC, and m68k.
> 
> Are you interested in a backport to 2.4.x?

On parisc we already have a version of the generic RTC driver in our
2.4 tree. If there's something more "official" or common we can adopt
that version. 

randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
