Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289906AbSAKJ0M>; Fri, 11 Jan 2002 04:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289908AbSAKJ0B>; Fri, 11 Jan 2002 04:26:01 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:32775 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289906AbSAKJZt>; Fri, 11 Jan 2002 04:25:49 -0500
Message-ID: <20020111092548.38249.qmail@web20508.mail.yahoo.com>
Date: Fri, 11 Jan 2002 10:25:48 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: Ronald.Wahl@informatik.tu-chemnitz.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is it possible to include an emulation for the CMOV*
(and
> possible other i686 instructions) for processors
that dont

I did something similar to emulate 486 instructions
for 386s
(bswap, cmpxchg...). You can reuse it if needed. It's 
available for 2.2 and 2.4 at this location :

http://www-miaif.lip6.fr/willy/linux-patches/486emulation/

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
