Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSGXUfb>; Wed, 24 Jul 2002 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGXUfa>; Wed, 24 Jul 2002 16:35:30 -0400
Received: from linuxpc1.lauterbach.com ([213.70.137.66]:16016 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S317623AbSGXUfa>; Wed, 24 Jul 2002 16:35:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: James Simmons <jsimmons@transvirtual.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Second set of console changes.
Date: Wed, 24 Jul 2002 22:38:24 +0200
User-Agent: KMail/1.4.2
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
References: <Pine.LNX.4.44.0207241157540.9506-100000@www.transvirtual.com>
In-Reply-To: <Pine.LNX.4.44.0207241157540.9506-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207242238.24359@enzo.bigblue.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 24. Juli 2002 22:08, James Simmons wrote:
> drivers/macintosh/mac_keyb.c

This one is obsolete for PPC (replaced by drivers/macintosh/adbhid.c), 
probably the same is true for m68k. Remove it as soon as Geert gives his OK.

Franz.

