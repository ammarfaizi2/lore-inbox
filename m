Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280947AbRKGVmO>; Wed, 7 Nov 2001 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKGVmG>; Wed, 7 Nov 2001 16:42:06 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:63814 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280947AbRKGVlz>; Wed, 7 Nov 2001 16:41:55 -0500
Date: Wed, 7 Nov 2001 21:40:29 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: "Todd M. Roy" <troy@holstein.com>, rml@tech9.net, mfedyk@matchmail.com,
        jimmy@mtc.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 compiling fail for loop device
Message-ID: <20011107214029.A22961@grobbebol.xs4all.nl>
In-Reply-To: <20011107204946.B13943@grobbebol.xs4all.nl> <0994FB93-D3C4-11D5-A232-00306569F1C6@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <0994FB93-D3C4-11D5-A232-00306569F1C6@haque.net>; from mhaque@haque.net on Wed, Nov 07, 2001 at 04:11:40PM -0500
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:11:40PM -0500, Mohammad A. Haque wrote:
> 
> On Wednesday, November 7, 2001, at 03:49 PM, Roeland Th. Jansen wrote:
> 
> > when mounting an EFS cd on the loop it also froze. this is _without_
> > removing the lines. ...
> 
> I'm a little confused. How did you even get a working kernel (or module) 
> without removing the lines?

oh sorry, little dazed & confused, this was with 2.4.13 like shown in
the tagline at that time. just compiled 2.2.14

-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.14 (noapic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
