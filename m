Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRFWUbX>; Sat, 23 Jun 2001 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRFWUbN>; Sat, 23 Jun 2001 16:31:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40007 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262684AbRFWUbC>; Sat, 23 Jun 2001 16:31:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: For comment: draft BIOS use document for the kernel
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jun 2001 14:26:32 -0600
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
Message-ID: <m1u217aqo7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Linux 2.4 BIOS usage reference

Pretty decent.  It misses a lot of hardware details that we still
depend on the BIOS to reliably setup for us.

I've got code that does all of this so, setup on a couple of
boards so it should just be a matter of tracking it down and including
it in the documentation.

If there is interest I'll start tracking it down as soon as I have a
free minute.

Eric
