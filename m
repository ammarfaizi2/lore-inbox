Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbUJ1T6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUJ1T6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUJ1T6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:58:22 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:48645 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262736AbUJ1Ty2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:54:28 -0400
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net>
	<200410280812.41150.gene.heskett@verizon.net>
	<87oeingerg.fsf@devron.myhome.or.jp>
	<200410281432.01013.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 29 Oct 2004 04:50:56 +0900
In-Reply-To: <200410281432.01013.gene.heskett@verizon.net> (Gene Heskett's
 message of "Thu, 28 Oct 2004 14:32:00 -0400")
Message-ID: <87zn261v1b.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> Now, how about its going read-only on me if I move (and delete) say 33 
> pix at the head of the its directory listing?  Is this an M$ related 
> fs bug in the camera?
>
> Thats required some contortions like camera battery removal, reboot 
> this machine, etc to alleviate and restore normal operations in the 
> past.

Umm... When filesystem became to read-only, is there the messages from
kernel (output of dmesg)?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
