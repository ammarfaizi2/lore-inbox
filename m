Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUJZSG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUJZSG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUJZSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:05:49 -0400
Received: from zamok.crans.org ([138.231.136.6]:50921 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261409AbUJZSEW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:04:22 -0400
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<58cb370e041026070067daa404@mail.gmail.com>
	<58cb370e0410261007145fc22c@mail.gmail.com>
	<87oeipcql4.fsf@barad-dur.crans.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 20:04:20 +0200
In-Reply-To: <87oeipcql4.fsf@barad-dur.crans.org> (Mathieu Segaud's message of
	"Tue, 26 Oct 2004 19:54:47 +0200")
Message-ID: <87k6tdcq57.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud <matt@minas-morgul.org> disait dernièrement que :

> reverting ide changes do not change anything....
> error is still here
> The only changes I can see now, are the md changes. I will try reverting it,
> and if I get no positive results, I give up (for today :))

obviously, md changes cannot have caused this failure....my mistake

I will dig again and again, if need be
-- 
dprintk(5, KERN_DEBUG "Jotti is een held!\n");
        linux-2.6.6/drivers/media/video/zoran_card.c

