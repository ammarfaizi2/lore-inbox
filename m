Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTGBQID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTGBQID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:08:03 -0400
Received: from codepoet.org ([166.70.99.138]:1249 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S265082AbTGBQIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:08:01 -0400
Date: Wed, 2 Jul 2003 10:22:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix 2.4.22-pre broken x86 math-emu
Message-ID: <20030702162225.GA10974@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030702030013.GA3405@codepoet.org> <Pine.LNX.4.55L.0307021051420.11896@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307021051420.11896@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 02, 2003 at 10:52:02AM -0300, Marcelo Tosatti wrote:
> 
> 
> I'm no GCC nor asm guru, so, Alan?

This does not change even one asm instruction.  This merely
changes the quoting and semicolons...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
