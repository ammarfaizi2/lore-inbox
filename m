Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSLKJeI>; Wed, 11 Dec 2002 04:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbSLKJeI>; Wed, 11 Dec 2002 04:34:08 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:14 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S267085AbSLKJeI>;
	Wed, 11 Dec 2002 04:34:08 -0500
Subject: Re: CD Writing in 2.5.51
From: mdew <mdew@orcon.net.nz>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87fzt43nm4.fsf@web.de>
References: <1039598049.480.7.camel@nirvana>  <87fzt43nm4.fsf@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 22:41:45 +1300
Message-Id: <1039599708.711.9.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 22:34, Markus Plail wrote:
> * mdew  writes:
> >So many howto's for writing in 2.4.x, simply put, what do i need
> >(kernel-wise) to get IDE CD writing going? 
> 
> >the lwn.net announcements dont really explain what needs to been done,
> >what modules need to be loaded (and what I dont need anymore) etc.
> 
> You don't need any additional modules. Just don't activate ide-scsi by
> either not appending ide-scsi/scsi=hdX or not compiling ide-scsi
> support in the kernel. 

can i completely remove scsi support then? (I dont have any scsi device)

-mdew

