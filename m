Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbTCWTo2>; Sun, 23 Mar 2003 14:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbTCWTo2>; Sun, 23 Mar 2003 14:44:28 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:61707 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S263165AbTCWTo1>; Sun, 23 Mar 2003 14:44:27 -0500
Message-Id: <200303231955.h2NJtWAx038337@sirius.nix.badanka.com>
Date: Sun, 23 Mar 2003 20:55:31 +0100
From: Henrik Persson <nix@socialism.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
In-Reply-To: <1048448838.1486.12.camel@phantasy.awol.org>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	<200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	<20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	<1048448838.1486.12.camel@phantasy.awol.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Mar 2003 14:47:19 -0500
Robert Love <rml@tech9.net> wrote:

> If you do not use a vendor kernel then you assume the responsibility of
> doing this stuff yourself.  If you do not want to worry about these
> things, use a vendor kernel.

Almost all of the people I know who are running Linux are compiling their
own kernels fetched from kernel.org and very few of them are tracking
LKML, so even if they should, they aren't.

Would it really hurt that much to release 2.4.21 with the ptracefix(es)?

If it hurts that much, can kernel.org put out a brief message and a link
to the relevant patches somewhere so that people who doesn't follow LKML
can find the patches without browsing the ML-archives?

-- 
Henrik Persson  nix@socialism.nu  http://nix.badanka.com
PGP-key: http://nix.badanka.com/pgp  PGP-KeyID: 0x43B68116  
