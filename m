Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTB0Poz>; Thu, 27 Feb 2003 10:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTB0Poy>; Thu, 27 Feb 2003 10:44:54 -0500
Received: from oumail.zero.ou.edu ([129.15.0.75]:6895 "EHLO r2d2.ou.edu")
	by vger.kernel.org with ESMTP id <S265339AbTB0Poy>;
	Thu, 27 Feb 2003 10:44:54 -0500
Date: Thu, 27 Feb 2003 09:55:08 -0600
From: Steve Kenton <skenton@ou.edu>
Subject: Re: [PATCH] 2.5.63 Nasssty little hobbitsses making ssso many
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <3E5E34DC.A4F39BCC@ou.edu>
Organization: The University Of Oklahoma
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; SunOS 5.8 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the look of the BK snapshot they *are* being integrated.
Linus probably knows better than anyone the problems this causes.
I think he's right, documentation both internal and external is
important if things are to mature.  Some will never want to fix
this sort of thing because it gets in the way of "real work" but
if it's going to be done it should be done before the next fork.

Steve

> Yes, I know this is a lot of work. But as it stands, it is a lot of
> _wasted_ work if the patches aren't being integrated.
