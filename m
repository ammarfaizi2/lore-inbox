Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136781AbREBAA7>; Tue, 1 May 2001 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136775AbREBAAu>; Tue, 1 May 2001 20:00:50 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:37086 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S136777AbREBAAV>; Tue, 1 May 2001 20:00:21 -0400
Message-ID: <3AEF4DCB.99D69E5B@mvista.com>
Date: Tue, 01 May 2001 16:59:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Erik Hensema <erik@hensema.xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Meaning of major kernel version number
In-Reply-To: <20010501224943.A21208@hensema.xs4all.nl> <01050123011105.04685@idun>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> On Tuesday,  1. May 2001 22:49, Erik Hensema wrote:
> > Hi,
> >
> > A little question which may be a FAQ: what does the major version number
> > [1] of the Linux kernel (still) mean? What is the policy on increasing the
> > major version (eg. on what basis it is decided the next kernel isn't going
> > to be 2.6 but 3.0)?
> 
> Our great fearless leader will talk with the penguin beyond the sky.
> 
>         HTH
>                 Oliver
> -
One definition might be that it changes when user code must be relinked
to work with the next version.

George
