Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280843AbRKTCm1>; Mon, 19 Nov 2001 21:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280839AbRKTCmR>; Mon, 19 Nov 2001 21:42:17 -0500
Received: from codepoet.org ([166.70.14.212]:63833 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280840AbRKTCmH>;
	Mon, 19 Nov 2001 21:42:07 -0500
Date: Mon, 19 Nov 2001 19:42:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LOBOS
Message-ID: <20011119194209.A32205@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Tim Hockin <thockin@hockin.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011119181731.D23210@work.bitmover.com> <200111200203.fAK23AA16724@www.hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111200203.fAK23AA16724@www.hockin.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 19, 2001 at 06:03:09PM -0800, Tim Hockin wrote:
> > I've been wanting Linux which can boot Linux for a long time.
> 
> This is what Cobalt firmware has been doing FOREVER.  We didn't solve it
> generically, but it works marvelously for what it does.

The netwinder firmware is a stripped down Linux kernel 
which boots another linux kernel.  
    ftp://ftp.netwinder.org/pub/ccc/firmware/

And the Linux BIOS project does that also 
    http://www.acl.lanl.gov/linuxbios/

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
