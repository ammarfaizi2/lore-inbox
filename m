Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTLJPxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTLJPxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:53:19 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:16527 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S263650AbTLJPxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:53:18 -0500
Date: Wed, 10 Dec 2003 16:50:39 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: chas williams <chas@cmf.nrl.navy.mil>
cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: Re: [Linux-ATM-General] Re: 2.4.22 with CONFIG_M686: networking
 broken 
In-Reply-To: <200312101413.hBAEDYTi000734@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.30.0312101640560.13525-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, chas williams wrote:

> In message <Pine.LNX.4.30.0312092344360.17719-100000@swamp.bayern.net>,Peter Da
> um writes:
> >... the same bug is still present in kernel version 2.4.23.
> >As I know meanwhile, it only occurs on ATM/LANE network connections.
>
> which atm card are you using?  if you are using a he155/622 then i am
> probably setting the cacheline size wrong.
>

It is a Marconi/Nicstar Forerunner LE 155 (IDT77211 rev. 3)



