Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTBPNIB>; Sun, 16 Feb 2003 08:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBPNIB>; Sun, 16 Feb 2003 08:08:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17798
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266640AbTBPNIA>; Sun, 16 Feb 2003 08:08:00 -0500
Subject: Re: Toshiba keyboard bug: point people to the patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       davyd@zdlcomputing.com
In-Reply-To: <20030215204436.GA8589@elf.ucw.cz>
References: <20030215204436.GA8589@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045405129.16464.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 14:18:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 20:44, Pavel Machek wrote:
> Hi!
> 
> Too many people mail me, and one of them was kind enough to put the
> patch on the web. It would be nice to have this in both 2.4.X and
> 2.5.X [patch against 2.5.61].

I sent Marcelo the fix and -ac has the fix in as well. Seems easier than
the dmi_scan warning 8)


