Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTAMAY5>; Sun, 12 Jan 2003 19:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbTAMAY5>; Sun, 12 Jan 2003 19:24:57 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:53770 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267687AbTAMAY4>; Sun, 12 Jan 2003 19:24:56 -0500
Message-ID: <3E2200C6.665A12CA@linux-m68k.org>
Date: Mon, 13 Jan 2003 00:56:54 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
References: <200301121512.59840.tomlins@cam.org> <20030112203150.GA53199@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

John Levon wrote:

> Can I just repeat my request to move this Qt stuff entirely out of the
> kernel package, where it belongs ?

We can discuss this during 2.7, until then I prefer to keep it close to
the kernel, as the config system still has to mature a bit more.

> The current detection doesn't even start to get things working
> correctly.

For example?

bye, Roman


