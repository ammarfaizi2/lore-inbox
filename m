Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbTC0KkV>; Thu, 27 Mar 2003 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTC0KkV>; Thu, 27 Mar 2003 05:40:21 -0500
Received: from [196.41.29.142] ([196.41.29.142]:23543 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261909AbTC0KkU>; Thu, 27 Mar 2003 05:40:20 -0500
Subject: Re: CRC errors decompressing kernel on boot
From: Martin Schlemmer <azarah@gentoo.org>
To: Pedro Soria Rodriguez <psoria@hispafuentes.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <1048760140.6984.11.camel@queen.pelusa.net>
References: <1047567911.3419.17.camel@queen.pelusa.net>
	 <1048760140.6984.11.camel@queen.pelusa.net>
Content-Type: text/plain
Organization: 
Message-Id: <1048762103.4775.1255.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 27 Mar 2003 12:48:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 12:15, Pedro Soria Rodriguez wrote:

> The problem turned out to be a combination of LILO and an apparently
> buggy BIOS. 
> 

I saw in changes to lilo-22.5.1_beta4, that he fixed some problems
with certain nvidia cards, where the VGA bios corrupts BX I think.
If you have a nvidia vga card, you might try lilo-22.5.1 when it
is released.


Regards,

-- 
Martin Schlemmer


