Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTDNSSa (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTDNSSa (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:18:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:53908 "EHLO
	arlx248.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263669AbTDNSSX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:18:23 -0400
Subject: Re: Benefits from computing physical IDE disk geometry?
From: Wes Felter <wesley@felter.org>
To: Timothy Miller <tmiller10@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
References: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Hack the Planet
Message-Id: <1050344844.1156.8.camel@arlx248.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2003 13:27:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 17:46, Timothy Miller wrote:

> So, what if one were to write a program which would perform a bunch of
> seek-time tests to estimate an IDE disk's physical geometry?  It could then
> make that information available to the kernel to use to reorder accesses
> more optimally.

Greg Ganger et al. have done some recent work in this area:

http://www.pdl.cmu.edu/PDL-FTP/stray/freeblocks_abs.html
http://www.pdl.cmu.edu/PDL-FTP/stray/traxtent_abs.html

-- 
Wes Felter - wesley@felter.org - http://felter.org/wesley/
