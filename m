Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264794AbSJaJd3>; Thu, 31 Oct 2002 04:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSJaJd3>; Thu, 31 Oct 2002 04:33:29 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:38517 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S264794AbSJaJd2>; Thu, 31 Oct 2002 04:33:28 -0500
Date: Thu, 31 Oct 2002 11:39:44 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
Message-ID: <20021031093944.GI1503@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20021031074604.GE2849@niksula.cs.hut.fi> <Pine.GSO.4.21.0210311021240.15053-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210311021240.15053-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:23:32AM +0100, you [Geert Uytterhoeven] wrote:
> 
> Except on m68k, where we've had a feature to store all kernel messages in an
> unused portion of memory (e.g. some Chip RAM on Amiga) and recover them after
> reboot since ages.

There was similar thing for x86 as well:

http://www.tux.org/hypermail/linux-kernel/1999week27/0782.html

Of course it never went to mainline (and I don't know how well it worked.)
>From what I understand, lkcd can support such method easily.


-- v --

v@iki.fi
