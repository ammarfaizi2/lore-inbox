Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287855AbSAFMtE>; Sun, 6 Jan 2002 07:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSAFMsx>; Sun, 6 Jan 2002 07:48:53 -0500
Received: from epic7.Stanford.EDU ([171.64.15.40]:38023 "EHLO
	epic7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S287850AbSAFMsl>; Sun, 6 Jan 2002 07:48:41 -0500
Date: Sun, 6 Jan 2002 04:48:35 -0800 (PST)
From: Vikram <vvikram@stanford.edu>
To: kumar M <kumarm4@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems in exporting symbols
In-Reply-To: <F154xe0ymQ1WE9ql2Rk00002adb@hotmail.com>
Message-ID: <Pine.GSO.4.33.0201060448010.27359-100000@epic7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


look at Documentation/Configure.help and specifically the
CONFIG_MODVERSION option.....

hope this helps.

	Vikram


On Sat, 5 Jan 2002, kumar M wrote:

> Hi,
>
> I am getting a kernel mismatch error when I insmod a binary module
> compiled on a 2.4.2 kernel (kernel name say linux-2-4-2-v1) on a different
> system with the same 2.4.2 kernel  but with  a different kernel name
> (linux-2-4-2-v2). I dont want to recompile the module everytime I give a new
> name to a kernel or for every different system.
> How do I fix this problem ?
>
> TIA,
> Kumar
>
>
>
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

