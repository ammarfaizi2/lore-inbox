Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUGLPzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUGLPzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUGLPzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:55:00 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:34713 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266837AbUGLPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:54:58 -0400
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: Naveen Kumar <naveenkrg@yahoo.com>
Subject: Re: Sending messages from kernel
Date: Mon, 12 Jul 2004 10:55:02 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040712111714.10763.qmail@web41108.mail.yahoo.com>
In-Reply-To: <20040712111714.10763.qmail@web41108.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121055.02790.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 06:17 am, Naveen Kumar wrote:
> Hi,
>
> I was trying to check if you can send a
> notification/message from kernel to a user space
> daemon.
>
> If you have answers/suggestions please mail me on
> this,
>
> Thanks in advance,
> Naveen.

Have you seen copy_to_user() and copy_from_user()?

> __________________________________
> Do you Yahoo!?
> New and Improved Yahoo! Mail - Send 10MB messages!
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

-EB
