Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSFFNOf>; Thu, 6 Jun 2002 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFFNOe>; Thu, 6 Jun 2002 09:14:34 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59118 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315517AbSFFNOd>; Thu, 6 Jun 2002 09:14:33 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <02060512070101.28263@henrique.cyclades.com.br> 
To: henrique@cyclades.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Conflicting symbols of zlib (jffs2 and ppp_deflate) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 14:14:33 +0100
Message-ID: <5752.1023369273@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


henrique@cyclades.com said:
>  I'd like to know if anyone (ppp and jffs2 guys) have a solution for
> this  problem or at least a suggestion. Any comment will be very
> welcomed.

ftp.??.kernel.org:/pub/linux/kernel/people/dwmw2/shared-zlib/linux-2.4.19-pre10-shared-zlib.{gz,bz2}

I'm intending to send this to Marcelo for 2.4.20-pre1, as soon as 2.4.19 is 
released.

--
dwmw2


