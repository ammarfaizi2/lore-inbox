Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbTCWT1K>; Sun, 23 Mar 2003 14:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTCWT1K>; Sun, 23 Mar 2003 14:27:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54896 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263160AbTCWT1J>; Sun, 23 Mar 2003 14:27:09 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
Subject: Re: Ptrace hole / Linux 2.2.25
To: mj@ucw.cz (Martin Mares)
Date: Sun, 23 Mar 2003 14:38:10 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), jgarzik@pobox.com (Jeff Garzik),
       skraw@ithnet.com (Stephan von Krawczynski), pavel@ucw.cz (Pavel Machek),
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> from "Martin Mares" at Mar 23, 2003 08:34:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but that's pretty irrelevant. People should not depend on such
> sources to get security fixes. Anything so critical should be included
> in the official kernel as soon as possible -- any reasons against?

Several
-	We aren't about to release an official kernel right now afaik,
	there are bugs left to sort out first
-	Anyone can apply the patch themselves
-	Anyone can go and get a vendor kernel
-	Anyone can go and release their own 2.4.20.1 or 2.4.20-sec or
	whatever if they feel strongly about it

Just go do it. If someone wants to be a contact point for build existing
base kernels + published security fix trees I'm pretty sure kernel.org
would host them too.

Alan

