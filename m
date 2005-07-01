Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbVGABCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbVGABCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 21:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVGABCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 21:02:10 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:51645 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S263182AbVGABCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 21:02:04 -0400
Date: Thu, 30 Jun 2005 22:01:57 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701010157.GA7877@ime.usp.br>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628161500.GA25788@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2005, Ben Collins wrote:
> On Tue, Jun 28, 2005 at 03:12:45AM -0300, Rog?rio Brito wrote:
> > Is there any other information that I can provide you with that would help
> > track this?
> 
> Diff git2's ieee1394 directory and the SVN repo from linux1394.org if you
> could.

Ok, I see that this is getting to be really important now, because I think
that Andrew forwarded some patches to Linus and now the Firewire enclosure
doesn't seem to work with 2.6.13-rc1 anymore (it works perfectly with
vanilla kernel 2.6.12).

The behaviour that I get with 2.6.13-rc1 is the same one that I got with
2.6.12-mm1 or 2.6.12-mm2. :-(

Oh, BTW, I just checked this with another drive, an iPod (2nd Generation)
and its partition table is also not read (like what happens with the drive
in the Firewire enclosure).

So, I guess that this is another data point that may be useful.


Thank you very much for your help, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
