Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281280AbRKETAu>; Mon, 5 Nov 2001 14:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281281AbRKETAl>; Mon, 5 Nov 2001 14:00:41 -0500
Received: from sfo1.somanet.net ([63.204.6.12]:25765 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S281280AbRKETAd>; Mon, 5 Nov 2001 14:00:33 -0500
Subject: Re: [PATCH] SMM BIOS on Dell i8100
From: "Georg Nikodym" <georgn@somanetworks.com>
To: stephane@tuxfinder.org
Cc: "Marcel J.E. Mol" <marcel@mesa.nl>, Massimo Dal Zotto <dz@debian.org>,
        LKLM <linux-kernel@vger.kernel.org>
In-Reply-To: <20011105180124.B17203@emeraude.kwisatz.net>
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net>
	<20011105130954.A24310@joshua.mesa.nl> 
	<20011105180124.B17203@emeraude.kwisatz.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.02.21.57 (Preview Release)
Date: 05 Nov 2001 14:00:22 -0500
Message-Id: <1004986822.1553.3.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 12:01, Stephane Jourdois wrote:

> Hope this helps, and if anybody knows how to implement keysyms, I'm
> interested... as long as I don't have to patch XFree86 !

No need.  Here's what I do with xmodmap:

!
! Dell 8000
! I have sawfish map these to
! xmms -u, -s, -r and -f respectively
!
keycode 129 = XF86AudioPlay
keycode 130 = XF86AudioStop
keycode 131 = XF86AudioPrev
keycode 132 = XF86AudioNext

