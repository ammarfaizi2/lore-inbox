Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTLXMTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 07:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLXMTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 07:19:54 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:8137 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263593AbTLXMTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 07:19:54 -0500
Message-ID: <123a01c3ca18$346117b0$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>, <mitch@sfgoth.com>
Subject: Re: SCO's infringing files list
Date: Wed, 24 Dec 2003 21:19:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Steven Cole wrote:
> > /* This is a list of all known signal numbers.  */
> >
> > CONST char *CONST _sys_errlist[] = {
>
> I wonder if there are any UNIX sources which have a similar typo.

That kind of error (typo, thinko, etc.) was more common than you think.  The
related file /usr/include/errno.h was source code readable by everyone.  If
anyone has a copy of errno.h from BSD days (when BSD wasn't completely free
yet), it would be worth checking.  If this comment was copied from BSD then
the next question is whether this comment originated at BSD or was copied
from ATT.

