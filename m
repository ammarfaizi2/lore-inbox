Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTGYT1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272269AbTGYT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:27:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45545 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272267AbTGYT1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:27:14 -0400
Date: Fri, 25 Jul 2003 16:38:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pekka Pietikainen <pp@netppl.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.4 shut up about "can't emulate rawmode for keycode
 272" with logitech cordless mice
In-Reply-To: <20030725070942.GA29589@netppl.fi>
Message-ID: <Pine.LNX.4.55L.0307251638360.15120@freak.distro.conectiva>
References: <20030725070942.GA29589@netppl.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jul 2003, Pekka Pietikainen wrote:

> Hi
>
> Could you please apply this patch to 2.4. It fixes a very annoying problem
> with logitech wireless keyboard/mouse combinations. Every time a
> mouse button is pressed the message
>
> keyboard.c: can't emulate rawmode for keycode 272
>
> appears on the console, which is somewhat annoying especially if you want
> to use gpm. For 2.5 this has been fixed by the patch in
> http://www.cs.helsinki.fi/linux/linux-kernel/2003-06/0754.html,
> Here's a similar patch for 2.4, which fixes the problem for me.

Applied,

Thanks pp.
