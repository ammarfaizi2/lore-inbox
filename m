Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSHJMRy>; Sat, 10 Aug 2002 08:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSHJMRy>; Sat, 10 Aug 2002 08:17:54 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:40975 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316889AbSHJMRx>; Sat, 10 Aug 2002 08:17:53 -0400
Date: Sat, 10 Aug 2002 14:21:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alexander Viro <viro@math.psu.edu>
cc: Christian Kurz <shorty@getuid.de>, <linux-kernel@vger.kernel.org>
Subject: Re: modules missing author name and/or description
In-Reply-To: <Pine.GSO.4.21.0208100758290.9847-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208101416580.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Aug 2002, Alexander Viro wrote:

> Quite a few modules don't _have_ a single author.  MODULE_AUTHOR is
> optional and very dubious at that

I agree, because of this I didn't add it to affs. MODULE_MAINTAINER
would be better and more useful.

bye, Roman

