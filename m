Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268912AbTGJEta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbTGJEta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 00:49:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268912AbTGJEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 00:49:29 -0400
Message-ID: <33376.4.4.25.4.1057813446.squirrel@www.osdl.org>
Date: Wed, 9 Jul 2003 22:04:06 -0700 (PDT)
Subject: Re: [PATCH] add seq file helpers from 2.5 (fwd)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.55L.0307100000100.6316@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307100000100.6316@freak.distro.conectiva>
X-Priority: 3
Importance: Normal
Cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>, <kernel@infidigm.net>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I didn't apply and build it, but it looks very much like the
patch that I sent to you on 2003-04-17 [1], to which you replied: [2]
  Saved to 2.4.22-pre folder.

I suggest that you apply it.  :)

~Randy

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105061808602830&w=2
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=105094575909669&w=2


> Viro,
>
> I think you are the right person to review that.
>
> Would you do me the favour?
>
> ---------- Forwarded message ----------
> Date: Wed, 09 Jul 2003 20:16:54 -0400
> From: Jeff Muizelaar <kernel@infidigm.net>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>
> Subject: [PATCH] add seq file helpers from 2.5
>
> Marcelo,
>
> The attached patch adds the single_* helpers that have been in 2.5 since May
> 2002, it also adds some missing includes that are in 2.5.
>
> -Jeff



