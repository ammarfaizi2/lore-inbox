Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSIKMpD>; Wed, 11 Sep 2002 08:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSIKMpD>; Wed, 11 Sep 2002 08:45:03 -0400
Received: from p50846B66.dip.t-dialin.net ([80.132.107.102]:25571 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S318747AbSIKMpC>;
	Wed, 11 Sep 2002 08:45:02 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.4.20-pre6
References: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 11 Sep 2002 14:49:46 +0200
In-Reply-To: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Wed, 11 Sep 2002 12:55:52 +0200 (MEST)")
Message-ID: <m365xcu1w5.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Wed, 11 Sep 2002, Adrian Bunk wrote:
>> On Tue, 10 Sep 2002, Marcelo Tosatti wrote:
>> 
>> >...
>> > Geert Uytterhoeven <geert@linux-m68k.org>:
>> >...
>> >   o Wrong fbcon_mac dependency
>> >...
>> 
> [SNIP]
>
> Hmmm... I didn't realize vesafb can use fbcon-mac.
>
> However, it seems to be used if you don't enable any of the fbcon-cfb* modules
> only, since fbcon-cfb* takes precendence.
>
> Do people really use 6x11 fonts with vesafb?

I don't use vesafb (as they (do they still?) tend to interfere with
accelerated X). "But I would if I did."

(Currently typing in an XEmacs on a 1600x1200 21" CRT using 6x13
font. No, I still don't get "enough" on one screen...)


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
