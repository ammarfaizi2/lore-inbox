Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271820AbRHWNQC>; Thu, 23 Aug 2001 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHWNPv>; Thu, 23 Aug 2001 09:15:51 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:16648 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S270121AbRHWNPn>; Thu, 23 Aug 2001 09:15:43 -0400
Subject: Re: (was posted)2.4.9-compilation error, pls help
From: Richard Russon <ntfs@flatcap.org>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010823125433.88094.qmail@web10402.mail.yahoo.com>
In-Reply-To: <20010823125433.88094.qmail@web10402.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 23 Aug 2001 14:15:41 +0100
Message-Id: <998572548.19873.1.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-08-23 at 13:54, Steve Kieu wrote:
> sorry but I lost the email and can not compile it. I
> still remember that someone made a patch available to
> fix it. pls show me :-))

Add this to unistr.c

  #include <linux/kernel.h>

FlatCap (Rich)
ntfs@flatcap.org




