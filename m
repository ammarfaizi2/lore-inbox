Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbTCWUCs>; Sun, 23 Mar 2003 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbTCWUCs>; Sun, 23 Mar 2003 15:02:48 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3091
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263172AbTCWUCq>; Sun, 23 Mar 2003 15:02:46 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Robert Love <rml@tech9.net>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303231955.h2NJtWAx038337@sirius.nix.badanka.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	 <1048448838.1486.12.camel@phantasy.awol.org>
	 <200303231955.h2NJtWAx038337@sirius.nix.badanka.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048450424.1486.24.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2003 15:13:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 14:55, Henrik Persson wrote:

> Would it really hurt that much to release 2.4.21 with the
> ptracefix(es)?

No, it would not.  But the point is Marcelo does not need to.  If he and
other kernel developers feel this course of action is better warranted,
then that is fine.

Users should rely on their vendors if they cannot rely on themselves.

Note that personally, I probably would of released a 2.4.21 with just
the ptrace security fix applied, as Alan did for 2.2.  But I am neither
Alan nor Marcelo, and the actions they both picked are OK.

	Robert Love

