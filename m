Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281284AbRKZAk5>; Sun, 25 Nov 2001 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281283AbRKZAks>; Sun, 25 Nov 2001 19:40:48 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:16611 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S281270AbRKZAkf>; Sun, 25 Nov 2001 19:40:35 -0500
Message-ID: <3C018F7F.FBEDCAAE@neo.shinko.co.jp>
Date: Mon, 26 Nov 2001 09:40:31 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: Sven.Riedel@tu-clausthal.de, kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de> <20011124185408.A13437@moog.heim1.tu-clausthal.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations!

Sven.Riedel@tu-clausthal.de wrote:
> Well, the problem got solved (although not in a way I'd consider
> satisfactory). After my machine started random segfaulting the day
> before yesterday, I memcheck86'ed it again (the last check is a mere two
> months ago), and lo - all three RAM chips were broken. Unfortunately, I
> discovered this, after this broken RAM caused my /usr partition to go
> fubar, resulting in me spending yesterday with a nice little reinstall.
> After the reinstall, 2.4.14 booted fine off the harddisk. No more
> oopses.

During this holidays, I guessed, and I thought it because of
harddisk or PCI chip erro. Memory error! Was it found when booting
matherboard by BIOS? I think motherboard always check memories when
booting.  

-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
