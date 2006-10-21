Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S2992821AbWJUFDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992821AbWJUFDo (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 21 Oct 2006 01:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992824AbWJUFDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 01:03:44 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:57772 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992821AbWJUFDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 01:03:44 -0400
Date: Fri, 20 Oct 2006 22:03:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Chris Largret <largret@gmail.com>
Subject: Re: 2.6.19-rc1, timebomb?
Message-ID: <20061021050341.GA32640@tuatara.stupidest.org>
References: <200610200130.44820.gene.heskett@verizon.net> <20061020212244.56f9f02b@localhost> <200610210037.57871.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610210037.57871.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 12:37:56AM -0400, Gene Heskett wrote:

> I guess I'm 'waiting for the other shoe to drop' Until that time,
> everything seems normal.  But I did just note that 'fam' is using up
> to 99.3% of the cpu, which is unusual considering that amanda is
> also running, and its usually gtar thats the hog.  This is according
> to htop.

I've had a few spontaneous restarts (which actually might have been
shutdowns, any key press will make the machine up so a power down when
working would probably look like a restart).

I've assumed these were heat related, mostly because they also
occurred when the CPU was working hard and the weather has been pretty
warm lately.
