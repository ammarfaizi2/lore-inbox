Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWAQPtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWAQPtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWAQPtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:49:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:33183 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750769AbWAQPtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:49:16 -0500
Date: Tue, 17 Jan 2006 07:48:46 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Roberto Oppedisano <roberto.oppedisano@infracomspa.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.15-git - compilation error: 'rcupdate' undeclared
Message-ID: <20060117154846.GA9094@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060112175943.GA13967@infracomspa.it> <20060117051941.GA7434@us.ibm.com> <20060117081722.GA5282@infracomspa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117081722.GA5282@infracomspa.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:17:22AM +0100, Roberto Oppedisano wrote:
> On Mon, Jan 16, 2006 at 09:19:41PM -0800, Paul E. McKenney wrote:
> > 2.6.15-git6 works builds and runs for me, with no compiler warnings
> > from rcupdate.c.  Exactly which version are you using?
> 
> This was with latest git from linus tree (after a git pull). Now I
> downloaded a 2.6.16-git9 via ftp and I can compile it successfully. 

Glad to hear it!

> Probably something has gone wrong with my git setup (also now, after a
> git pull/git checkout -f, I still can't compile it). 

On this I must defer to git experts, which I am not.

						Thanx, Paul
