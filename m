Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269957AbRHENFB>; Sun, 5 Aug 2001 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269955AbRHENEl>; Sun, 5 Aug 2001 09:04:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28427 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269953AbRHENEe>; Sun, 5 Aug 2001 09:04:34 -0400
Subject: Re: /proc/<n>/maps getting _VERY_ long
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 5 Aug 2001 14:06:16 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010805171202.A20716@weta.f00f.org> from "Chris Wedgwood" at Aug 05, 2001 05:12:02 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TNbk-0007pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Ouch, what kind of application is this happening with ?
> 
> Mozilla.  Presumably some of the Gnome applications might be the same
> as they use lots and lots of shared libraries (anyone out there Gnome
> inflicted and can check?).
> 
> Why do we no longer merge? Is it too expensive?  If so, perhaps we

Linus took itout because it was quite complex and nobody seemed to have
cases that triggered it or made it useful
