Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282497AbRLSTC4>; Wed, 19 Dec 2001 14:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282495AbRLSTCh>; Wed, 19 Dec 2001 14:02:37 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:47855 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S282497AbRLSTCd>; Wed, 19 Dec 2001 14:02:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eli <eli@pflash.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x WinBookXL mouse & keyboard freeze
Date: Wed, 19 Dec 2001 12:54:43 -0600
X-Mailer: KMail [version 1.3.1]
Cc: eli@pflash.com, arjanv@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Glz1-0005mt-00@pintail.mail.pas.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 12:33 pm, Eli wrote:
> When running any 2.4.x kernel, if gpm is running, touching the mouse ends
> all keyboard input.  Starting X without touching the mouse does the same
> thing. The mouse in this case is the built-in trackpad thing common in
> notebooks. 2.2.x works just fine.
>
> I don't know quite where to start on this... I've tried changing gpm
> configuration, but that doesn't seem to help.
> (I'm running RedHat 7.2.)
>
> Any ideas on where I should start looking?

Ok, I found discussion of this bug here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=37812

I'll start playing with some of the ideas listed, but I don't see a good 
conclusion on it.  What kind of a fix would be accepted into the mainline?

TIA,

Eli
---------------.
Eli Carter      \
eli(a)pflash.com `-------------------------------------------------------
