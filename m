Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSFZPUG>; Wed, 26 Jun 2002 11:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFZPUF>; Wed, 26 Jun 2002 11:20:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48075 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316629AbSFZPUE>; Wed, 26 Jun 2002 11:20:04 -0400
Date: Wed, 26 Jun 2002 08:19:54 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <taka@valinux.co.jp>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: efficient copy to user and copy from user routines in Linux
Message-ID: <Pine.LNX.4.33.0206260813250.6540-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a patch which let sendmsg use copy_from_user 
> instead of csum_and_copy_from_user when a NIC supports 
> HW-checksumming.  It just works on kernel 2.4, I haven't 
> ported it on kernel 2.5 yet.
> If you want it I'll port it after I come back from OTTAWA.

I believe Mala has run with just such a patch independently
(not looked at it yet) provided by me, but dont believe her
current results include that patch..

thanks,
Nivedita

