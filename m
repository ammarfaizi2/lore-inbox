Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276707AbRKAAdp>; Wed, 31 Oct 2001 19:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRKAAde>; Wed, 31 Oct 2001 19:33:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61701 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276707AbRKAAdV>; Wed, 31 Oct 2001 19:33:21 -0500
Subject: Re: Stress testing 2.4.14-pre6
To: bmatthews@redhat.com (Bob Matthews)
Date: Thu, 1 Nov 2001 00:40:36 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BE073B6.BDCB3D56@redhat.com> from "Bob Matthews" at Oct 31, 2001 04:57:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15z5uO-0005Z7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, this is as detailed a bug report as I can submit.  It
> looks like Magic SysRq is broken in this kernel.  <alt><SysRq>T will
> print the column headings but nothing else.

Thats consistent with memory corruption trashig the task list
