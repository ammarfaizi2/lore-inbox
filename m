Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKNSsJ>; Thu, 14 Nov 2002 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSKNSsI>; Thu, 14 Nov 2002 13:48:08 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:55568 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261721AbSKNSsH>; Thu, 14 Nov 2002 13:48:07 -0500
Date: Thu, 14 Nov 2002 19:54:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
In-Reply-To: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211141950320.2109-100000@serv>
References: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Nov 2002, Linus Torvalds wrote:

> (There are some other patches I'm still thinking about, notably kprobes
> and posix timers, but other than that my plate is fairly empty froma
> feature standpoint. And the kexec stuff I want others to test, at least
> now it's palatable to me).

Linus, please also consider LTT. The benefits might not be immediately 
visible, but it's great tool to the analyze system behaviour, which can 
even be used by non kernel hackers. This means as soon normal users start 
testing 2.5, they're not limited to fuzzy error messages, but they can 
tell you what actually happens, when the system doesn't "feel" right.

bye, Roman

