Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUBWKYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUBWKYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:24:30 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:59041 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261908AbUBWKY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:24:29 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Date: Mon, 23 Feb 2004 15:54:14 +0530
User-Agent: KMail/1.5
References: <20040222160417.GA9535@elf.ucw.cz> <20040222202211.GA2063@mars.ravnborg.org> <20040222210224.GB16779@elf.ucw.cz>
In-Reply-To: <20040222210224.GB16779@elf.ucw.cz>
Cc: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402231554.14959.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 Feb 2004 2:32 am, Pavel Machek wrote:
> Hi!
>
> > +static const char hexchars[] = "0123456789abcdef";
> > Grepping after 0123456789 in the src tree gives a lot of hits.
> > Maybe we should pull in some functionality from klibc, and place it in
> > lib/ at some point in time.
>
> This one will have to wait, I fixed the others in the internal tree.

Looks good.
Please checkin unless someone shouts.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

