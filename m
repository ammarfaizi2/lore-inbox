Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWAQOJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWAQOJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWAQOJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:09:41 -0500
Received: from [217.12.176.9] ([217.12.176.9]:7052 "EHLO poppero1")
	by vger.kernel.org with ESMTP id S932503AbWAQOJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:09:40 -0500
Date: Tue, 17 Jan 2006 09:17:22 +0100
From: Roberto Oppedisano <roberto.oppedisano@infracomspa.it>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.15-git - compilation error: 'rcupdate' undeclared
Message-ID: <20060117081722.GA5282@infracomspa.it>
References: <20060112175943.GA13967@infracomspa.it> <20060117051941.GA7434@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117051941.GA7434@us.ibm.com>
X-NCC-RegID: it.infracom
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:19:41PM -0800, Paul E. McKenney wrote:
> 2.6.15-git6 works builds and runs for me, with no compiler warnings
> from rcupdate.c.  Exactly which version are you using?

This was with latest git from linus tree (after a git pull). Now I
downloaded a 2.6.16-git9 via ftp and I can compile it successfully. 

Probably something has gone wrong with my git setup (also now, after a
git pull/git checkout -f, I still can't compile it). 

ciao, Roberto
-- 
Roberto Oppedisano
Infracom Italia S.p.A.                         OSS and LIR Services
Tel. +39 045 8271518   Fax  +39 045 8271499   Cell. +39 348 7419534
