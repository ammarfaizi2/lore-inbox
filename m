Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSBKNUE>; Mon, 11 Feb 2002 08:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289020AbSBKNTz>; Mon, 11 Feb 2002 08:19:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50445 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289013AbSBKNTs>; Mon, 11 Feb 2002 08:19:48 -0500
Subject: Re: faking time
To: super.aorta@ntlworld.com (SA products)
Date: Mon, 11 Feb 2002 13:33:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com> from "SA products" at Feb 11, 2002 11:49:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aGaN-0006b2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to fake the time returned by the time() system call so that for a
> limited number
> of user space programs the time can be set to the future or the past
> without affecting
> other applications and without affecting system time-- Ideally I would
> like to install a
> loadable module to accomplish this- Any hints ? Any starting points?

The timetravel module that Tigran wrote for Y2K testing should do. 

Alan
