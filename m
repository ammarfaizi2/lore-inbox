Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSHDBOB>; Sat, 3 Aug 2002 21:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSHDBOB>; Sat, 3 Aug 2002 21:14:01 -0400
Received: from ppp71-3-70.miem.edu.ru ([194.226.32.70]:6784 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S318044AbSHDBOA>;
	Sat, 3 Aug 2002 21:14:00 -0400
Message-ID: <3D4C7F0F.9000807@yahoo.com>
Date: Sun, 04 Aug 2002 05:10:39 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac1
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
  >  * indicates stuff that is merged in mainstream now, X
  > stuff that proved
[snip]
  > Linux 2.4.19pre4-ac4
  > * Fix an additional vm86 case (Stas Sergeev)
Despite marked with *, this
patch still exists only in
-ac tree.

The patch can be found here:
http://dosemu.sourceforge.net/stas/traps.diff
It is intended to fix a vm86-related
Oopses of this kind:
Aug  4 04:45:18 localhost kernel: invalid operand: 0000

I guess it's just a typo in a
changelog, this * must actually
be o.

