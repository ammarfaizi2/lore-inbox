Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUAFB4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUAFB4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:56:15 -0500
Received: from [211.167.76.68] ([211.167.76.68]:42415 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265232AbUAFB4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:56:13 -0500
Date: Tue, 6 Jan 2004 09:31:45 +0800
From: Hugang <hugang@soulinfo.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Bastiaan Spandaw <lkml@becobaf.com>,
       Tomas Szepe <szepe@pinerecords.com>, Max Valdez <maxvalde@fis.unam.mx>
Subject: Re: 2.6.1-rc1 affected?
Message-Id: <20040106093145.0fd0d4b5@localhost>
In-Reply-To: <Pine.LNX.4.56.0401060221170.7597@jju_lnx.backbone.dif.dk>
References: <1073351377.2690.1.camel@garaged.homeip.net>
	<Pine.LNX.4.56.0401060221170.7597@jju_lnx.backbone.dif.dk>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004 02:25:36 +0100 (CET)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> 
> On Tue, 6 Jan 2004, Max Valdez wrote:
> 
> > At least it hangs a redhat 7.2 kernel
> >
> > I will test it further tomorrow, but it looks like a good proof to me
> On my box that program is a very effective 'instant reboot'.
> 
> The instant I ran it from a xterm my screen went black, the music I was
> listening to from a CD stopped and the machine rebooted.
> The running kernel was 2.6.1-rc1-mm1

do nothing in my laptop.

[hugang@:build]$ ./mremap_poc 
Trace/breakpoint trap

powerpc G4, PowerBook G4, 2.6.0-test11-wli + laptop mode path

-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
