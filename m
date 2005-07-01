Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263146AbVGACX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbVGACX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 22:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVGACX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 22:23:58 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:30346 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S263146AbVGACX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 22:23:56 -0400
Date: Thu, 30 Jun 2005 23:23:54 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701022354.GB8863@ime.usp.br>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050701011226.GB2067@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30 2005, Ben Collins wrote:
> On Thu, Jun 30, 2005 at 10:01:57PM -0300, Rog?rio Brito wrote:
> > On Jun 28 2005, Ben Collins wrote:
> > > On Tue, Jun 28, 2005 at 03:12:45AM -0300, Rog?rio Brito wrote:
> > > > Is there any other information that I can provide you with that would help
> > > > track this?
> > > 
> > > Diff git2's ieee1394 directory and the SVN repo from linux1394.org if you
> > > could.
> 
> Where are these patches coming from? Also, have you tried using 2.6.13-rc1
> using linux1394.org's subversion tree?

I don't know where the patches are coming from. I have just checked out the
trunk version of the subversion tree from linux1394.org. I will diff it
against the Linux tree that I have here.

Humm, I have just diffed both trees and there is a fair amount of changes
between both versions (i.e., between Linux 2.6.13-rc1 and the trunk tree
from linux1394.org).

The diff (in this order) is at http://www.ime.usp.br/~rbrito/bug/, if you
can comment on it.

I can provide any other information that is needed. Just let me know what
is desired.


Thank you very much, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
