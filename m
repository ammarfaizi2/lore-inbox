Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290040AbSAKR4N>; Fri, 11 Jan 2002 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290041AbSAKR4E>; Fri, 11 Jan 2002 12:56:04 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:23680 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S290040AbSAKRz6>; Fri, 11 Jan 2002 12:55:58 -0500
To: willy tarreau <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <20020111092548.38249.qmail@web20508.mail.yahoo.com>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 18:55:56 +0100
In-Reply-To: <20020111092548.38249.qmail@web20508.mail.yahoo.com>
Message-ID: <m2n0zkn55f.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 10:25:48 +0100 (CET), willy tarreau wrote:

>> is it possible to include an emulation for the CMOV*
> (and
>> possible other i686 instructions) for processors
> that dont

> I did something similar to emulate 486 instructions
> for 386s
> (bswap, cmpxchg...). You can reuse it if needed. It's 
> available for 2.2 and 2.4 at this location :

> http://www-miaif.lip6.fr/willy/linux-patches/486emulation/

Thanks! I will have a look into it.

ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
