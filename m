Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTAKBfp>; Fri, 10 Jan 2003 20:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTAKBfp>; Fri, 10 Jan 2003 20:35:45 -0500
Received: from havoc.daloft.com ([64.213.145.173]:38870 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266989AbTAKBfo>;
	Fri, 10 Jan 2003 20:35:44 -0500
Date: Fri, 10 Jan 2003 20:44:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY AND PERFORMANCE
Message-ID: <20030111014425.GC25649@gtf.org>
References: <OFD6D876A7.7D7E3A46-ON85256CAA.0068C7D5@us.ibm.com> <200301110203.09346.m.c.p@gmx.net> <3E1F72D7.7050505@lexus.com> <20030111013346.GB25649@gtf.org> <200301110141.h0B1f9LK017119@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301110141.h0B1f9LK017119@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 08:41:09PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Jan 2003 20:33:46 EST, Jeff Garzik said:
> > You are correct:  you need a recent 2.5 kernel and a recent glibc.

> I'll bite - how recent a glibc?  Does the 2.3.1 RPM that RedHat included
> on the Phoebe beta qualify, or do we need even more bleeding-edge?

AFAIK, yes, it was included in the Phoebe beta.

However, I also pretty sure that fixes have been made since then, so I
would grab the latest glibc from cvs...  This is unfortunately a better
question for the glibc lists ;-)

	Jeff




