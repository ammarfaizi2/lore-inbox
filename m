Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273981AbRIXQV0>; Mon, 24 Sep 2001 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273989AbRIXQVQ>; Mon, 24 Sep 2001 12:21:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273981AbRIXQVJ>; Mon, 24 Sep 2001 12:21:09 -0400
Subject: Re: Linux 2.4.9-ac15
To: whitney@math.berkeley.edu
Date: Mon, 24 Sep 2001 17:25:58 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <200109241610.f8OGAUk19897@adsl-209-76-109-63.dsl.snfc21.pacbell.net> from "Wayne Whitney" at Sep 24, 2001 09:10:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lYYQ-00032z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the patch file on ftp.kernel.org (and some of the mirrors
> already) is incomplete.  That is, it does not contain
> scripts/mkversion, so it does not compile.  Plus it is noticeably
> smaller than the patch file for -ac14.

Should be 4685943 bytes. I've corrected master.kernel.org where I made
the error, hopefully it will flow out to the others
