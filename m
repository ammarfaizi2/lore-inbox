Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262571AbTCITTc>; Sun, 9 Mar 2003 14:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbTCITTb>; Sun, 9 Mar 2003 14:19:31 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27911 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262571AbTCITTb>; Sun, 9 Mar 2003 14:19:31 -0500
Date: Sun, 9 Mar 2003 20:30:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
In-Reply-To: <20030309190103.GA1170@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303092028020.32518-100000@serv>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
 <20030309190103.GA1170@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Sam Ravnborg wrote:

> Hi Roman.
> Is it on your TODO list to make is more quiet?
> Today kconfig dumps out a lot of info when run, making sure no-one even
> notices the warnings that occur in the beginning.
> When executing
> $ make defconfig
> $ make V=0
> kconfig count for almost half of the output.

What do you mean? 2.5.64 has no V option.

bye, Roman

