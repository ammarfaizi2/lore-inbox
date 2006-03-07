Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWCHJ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWCHJ3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWCHJ3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:29:44 -0500
Received: from secure.htb.at ([195.69.104.11]:9226 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932528AbWCHJ3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:29:43 -0500
Date: Wed, 8 Mar 2006 00:45:55 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SUSPEND] Screen slides down after STR / neomagic
Message-Id: <20060308004555.fe20b052.delist@gmx.net>
In-Reply-To: <20060307214337.GA1777@elf.ucw.cz>
References: <20060306100905.0199e7b5.delist@gmx.net>
	<20060307214337.GA1777@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FGlsx-000118-00*QWkEXIqesBQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@ucw.cz> (Tue, 7 Mar 2006 22:43:37
+0100):
> On Po 06-03-06 10:09:05, Richard Mittendorfer wrote:
> > Hello,
> > 
> > Toshiba Libretto; Every time I suspend to RAM an come back to Console or
> > later exit Xorg (it's ok within X), the screen is somewhat displaced
> > downward:
> 
> Did you read Doc*/power/video.txt?

Oh, wasn't aware of this file. (Havn't looked there for a while now.)
Now I know what went wrong. :-)

Finally the vbetool trick did it.

thx, ritch
