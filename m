Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUFTRTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUFTRTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUFTRTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:19:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:55525 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265501AbUFTRSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:18:47 -0400
Date: Sun, 20 Jun 2004 19:17:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arun Sen <arunsen@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Restating the questions
In-Reply-To: <02d701c456da$ee397a20$6401a8c0@waterdell>
Message-ID: <Pine.LNX.4.56.0406201909370.20352@jjulnx.backbone.dif.dk>
References: <02d701c456da$ee397a20$6401a8c0@waterdell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Arun Sen wrote:

> Q1.  I want to find out what the steps are for submitting and approving a
> patch in the Linux kernel?   I know that Linus has sent out an email
> regarding the patch approval process and I have read it.
>
Read Documentation/SubmittingPatches
Read http://www.tux.org/lkml/#s1-10

> Q2.  I have looked into a mirror site for the kernel (in the university of
> Wisconsin web site) for all kinds of patches for the kernel.  I am looking
> at all patches for all versions of the kernel.  I would like to find out who
> the authors are of these patches.  Can you help me find this info?
>
ftp://ftp.kernel.org/pub/linux/kernel - for most recent versions
ChangeLogs are available, amongst other things the ChangeLogs contain info
on who wrote or submitted the patch. For more info read the MAINTAINERS
& CREDITS files as well as source code comments in the source files
themselves.

Other people can probably point you at more...

Btw, what are you going to use this info for? I'm currious (and I'm sure
other people are as well).

--
Jesper Juhl <juhl-lkml@dif.dk>


