Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbTGENZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 09:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbTGENZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 09:25:23 -0400
Received: from pc-4082.ethz.ch ([129.132.66.114]:17061 "EHLO mail.netbeast.org")
	by vger.kernel.org with ESMTP id S266344AbTGENZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 09:25:22 -0400
Date: Sat, 5 Jul 2003 15:39:39 +0200
From: Lukas Ruf <ruf@rawip.org>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Error in cs46xx.c]
Message-ID: <20030705133939.GE23360@tik.ee.ethz.ch>
Mail-Followup-To: Linux Kernel ml <linux-kernel@vger.kernel.org>
References: <3F05D28B.8090902@t-online.de> <1057411831.23488.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057411831.23488.0.camel@dhcp22.swansea.linux.org.uk>
X-GPG: 0xED6F778D -- visit http://www.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> [2003-07-05 15:35]:
> On Gwe, 2003-07-04 at 20:16, Mikeb1 wrote:
> > -------- Original Message --------
> > Subject: Error in cs46xx.c
> > Date: Fri, 04 Jul 2003 20:52:06 +0200
> > From: Mikeb1 <mikeb1@t-online.de>
> > Newsgroups: linux.kernel
> > 
> > Dear kernel hackers:
> > 
> > I got the following compile error with 2.4.21
> 
> Linux 2.4.x isnt yet set up to build with the new gcc 3.3

but it's easy to get it to compile -- at least with the options I
selected for my host.  I made use of:

komsys-pc-ruf:~!53> gcc --version
gcc (GCC) 3.3.1 20030626 (Debian prerelease)

Would there be any interest I would provide the changes created as
diffs?

wbr,
Lukas
-- 
Lukas Ruf           | Wanna know anything about raw |
<http://www.lpr.ch> | IP?  <http://www.rawip.org>   |
