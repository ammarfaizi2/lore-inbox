Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbRBXRAi>; Sat, 24 Feb 2001 12:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129461AbRBXRA3>; Sat, 24 Feb 2001 12:00:29 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:16132 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129458AbRBXRAX>; Sat, 24 Feb 2001 12:00:23 -0500
Date: Sat, 24 Feb 2001 15:29:13 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 broke gcd (or, audio CD's won't play)
Message-ID: <20010224152913.A4604@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010223183743.A26519@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15-current-20010213i (Linux 2.4.2 i586)
In-Reply-To: <20010223183743.A26519@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Fri, Feb 23, 2001 at 06:37:43PM -0600
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 23 2001, Steven Walter wrote:

> After upgrading to 2.4.2, gcd or any audio CD player will work.  The
> attached chunk of dmesg is the messages produced by attempting to play
> them.  The player just loops through all tracks, playing nothing.

Here, xmcd and cda both work perfectly.

Linux elfie 2.4.2 #1 Thu Feb 22 10:52:17 CET 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Gnu Make               3.79
Binutils               2.10.91.0.2
Linux C Library        2.2.2
Dynamic linker         ldd (GNU libc) 2.2.2
Linux C++ Library      2.9.0
Procps                 2.0.2
Mount                  2.10r
Net-tools              1.46
Kbd                    0.96
Sh-utils               1.12
Modules Loaded         serial

-- 
# Heinz Diehl, 68259 Mannheim, Germany
