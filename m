Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTEFMmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTEFMmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:42:17 -0400
Received: from [203.94.130.164] ([203.94.130.164]:60112 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S262709AbTEFMmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:42:16 -0400
Date: Tue, 6 May 2003 22:34:04 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
In-Reply-To: <20030506124249.GG20419@wiggy.net>
Message-ID: <Pine.LNX.4.44.0305062230420.2201-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Wichert Akkerman wrote:

> Previously Brett wrote:
> > (0.93 fails to compile, reported to grub savannah page, and have heard 
> > nothing back from)
> 
> 0.92 is over a year old and a lot has changed since then. Debian has
> grub 0.93 packages which work fine with 2.5.67-69 for me, you could try
> that.
> 

linuxfromscratch system
unless they fix the source compilation problem i reported
<http://savannah.gnu.org/bugs/?func=detailbug&bug_id=3343&group_id=68>
then i can't install it

and anyway, can you provide any backup that this will fix it ?? what 
changed between 2.5.66 and 2.5.67 to stop grub loading the kernel ? why 
hasn't anyone else reported this ???

i'm just highly dubious that upgrading grub one revision will help

and it isn't something i can do right now anyway

thanks,

	/ Brett

