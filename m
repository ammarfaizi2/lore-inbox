Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280769AbRKSXbm>; Mon, 19 Nov 2001 18:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280771AbRKSXbb>; Mon, 19 Nov 2001 18:31:31 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:15857 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S280769AbRKSXbN>; Mon, 19 Nov 2001 18:31:13 -0500
Message-ID: <3BF99639.5FB5694E@neo.shinko.co.jp>
Date: Tue, 20 Nov 2001 08:31:05 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: Sven.Riedel@tu-clausthal.de
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de> <3BF32B36.8B1375D0@neo.shinko.co.jp> <20011115042843.A383@moog.heim1.tu-clausthal.de> <3BF376BC.B184E954@neo.shinko.co.jp> <20011115112214.A10796@moog.heim1.tu-clausthal.de> <3BF456CF.B7C0FFEB@neo.shinko.co.jp> <20011116202230.A890@moog.heim1.tu-clausthal.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me, I had holidays.

Sven.Riedel@tu-clausthal.de wrote:
> 
> On Fri, Nov 16, 2001 at 08:59:11AM +0900, nakai wrote:
> > I am using 2.4.2 kernel, because 2.4.10's ide-pci has
> > something wrong with promise IDE cards. I did not check about
> > HPT366 chip, but I think it would be better 2.4.2 kernel.
> Could the EIDE code cause problems that far up in the kernel booting
> procedure? The IDE drivers aren't loaded yet at that point...

Yes, you are right.

May I ask you how to get /proc/pci ?
Is there any kernel which can run ?
Is it correctly hardware trouble or kernel trouble ?

-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
