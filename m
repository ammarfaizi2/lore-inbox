Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRHALC6>; Wed, 1 Aug 2001 07:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHALCs>; Wed, 1 Aug 2001 07:02:48 -0400
Received: from [63.209.4.196] ([63.209.4.196]:38663 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266580AbRHALCb>; Wed, 1 Aug 2001 07:02:31 -0400
To: linux-kernel@vger.kernel.org
Cc: xinyuepeng@yahoo.com
Subject: Re: A problem about the mkcramfs!
In-Reply-To: <20010730080303.45417.qmail@web20005.mail.yahoo.com>
From: Daniel Quinlan <quinlan@transmeta.com>
Date: 01 Aug 2001 04:00:36 -0700
In-Reply-To: =?gb2312?q?=D0=C2=20=D4=C2?='s message of "Mon, 30 Jul 2001 16:03:03 +0800 (CST)"
Message-ID: <6ypuagavu3.fsf@sodium.transmeta.com>
X-Mailer: Gnus v5.7/Emacs 20.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xinyuepeng@yahoo.com writes:

> The mkcramfs uses a function "compress",which is
> defined in 'zlib.h'.I feel it is a bit odd,which 
> is defined as following:
> 
>  ZEXTERN int ZEXPORT compress OF((Bytef *dest,uLongf
> *destLen,const Bytef *source, uLong sourceLen));
> 
> And I can't find its body,only find definition.I want
> to get explanation.Thanks

http://www.gzip.org/zlib/manual.html !

 Dan

