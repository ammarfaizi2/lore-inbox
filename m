Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbTCTV5q>; Thu, 20 Mar 2003 16:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbTCTV5q>; Thu, 20 Mar 2003 16:57:46 -0500
Received: from buug.mind.de ([212.42.230.8]:37816 "EHLO mail.buug.de")
	by vger.kernel.org with ESMTP id <S262643AbTCTV5o>;
	Thu, 20 Mar 2003 16:57:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Release of 2.4.21
Mail-Followup-To: linux-kernel@vger.kernel.org
From: krause@sdbk.de (Sebastian D.B. Krause)
Date: Thu, 20 Mar 2003 23:08:43 +0100
In-Reply-To: <20030320210305.GH8256@gtf.org> (Jeff Garzik's message of "Thu,
 20 Mar 2003 16:03:05 -0500")
Message-ID: <871y11y9lg.fsf@sdbk.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <20030320200019$6ddc@gated-at.bofh.it>
	<20030320203015$4839@gated-at.bofh.it> <8765qdg46i.fsf@deneb.enyo.de>
	<20030320210305.GH8256@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3487 September 1993, Jeff Garzik wrote:
> The ptrace bug is only one of several local root holes.  IIS would imply
> a remote vulnerability, something _far_ more serious.
>
> This specific ptrace hole is closed, yay.  Now what about the other
> 10,001 that still exist?  People are blowing this ptrace bug WAY
> out of proportion.

That may be true, but inspite of that there is another important and
dangerous bug in 2.4.20 (the ext3 thing) that IMHO is enough reason
to release a new kernel.
