Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280832AbRKTCAb>; Mon, 19 Nov 2001 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKTCAW>; Mon, 19 Nov 2001 21:00:22 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:51353 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280832AbRKTCAF>;
	Mon, 19 Nov 2001 21:00:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Dan Merillat <harik@chaos.ao.net>
Subject: Re: radeonfb bug: text ends up scrolling in the middle of tux.
Date: Mon, 19 Nov 2001 17:59:46 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111200133.fAK1XT2J000773@vulpine.ao.net>
In-Reply-To: <200111200133.fAK1XT2J000773@vulpine.ao.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1660CQ-0001CY-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 17:33, Dan Merillat wrote:
> Ok, I've poked around but I can't find a penguin or tux bitmap to
> figure out why scrolling is so broken.  I've got to login blind and type
> reset to get the console back.  Needless to say, no kernel messages
> are readable after the mode-switch (they all overwrite themselves on
> a single line)

Type 'dmesg' as root to get all your lost kernel messages back. Hopefully 
they'll shed some light on the problem.

-Ryan
