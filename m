Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSHOLiN>; Thu, 15 Aug 2002 07:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHOLiN>; Thu, 15 Aug 2002 07:38:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41231 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316788AbSHOLiN>; Thu, 15 Aug 2002 07:38:13 -0400
Message-Id: <200208151137.g7FBbNp20417@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Daniel Phillips <phillips@arcor.de>, Andrew Rodland <arodland@noln.com>,
       Stas Sergeev <stssppnn@yahoo.com>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Thu, 15 Aug 2002 14:34:17 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D5A8C2C.9010700@yahoo.com> <200208150821.g7F8L6p19730@Port.imtp.ilyichevsk.odessa.ua> <E17fI5E-0002at-00@starship>
In-Reply-To: <E17fI5E-0002at-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 August 2002 08:42, Daniel Phillips wrote:
> > Of course I understand the desire to make simple hardware do nice and
> > unexpected things which it even wasn't designed to do.  :-)  Maybe ALSA
> > team have some member crazy enough to join you.
>
> You simply argued that because it might not work well for everybody, then
> nobody should have it.  I hope you see the fallacy.

It won't work well for everybody, then it won't live in mainline.
Because newcomers will enable it, be pissed off with crap sound etc...
"Political" reasons I'm afraid...

I don't say that driver is useless or something similar.
I'd object to such statement myself. It is fun to play with.

Keeping it as a separate patch is completely sane thing to do.

> I have two machines here that want it, and on which it works fine.  One of
> them is a modern server.
>
> It's a small patch and decently coded.  Sure, it could use a little more
> work, but that is exactly what it will get if it's in mainline.  I'm in
> favor of seeing this in mainline.

Me too, but my initials are not LT :(
--
vda
