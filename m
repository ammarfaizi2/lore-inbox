Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSJ0SrA>; Sun, 27 Oct 2002 13:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJ0SrA>; Sun, 27 Oct 2002 13:47:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53120 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262490AbSJ0Sq7>; Sun, 27 Oct 2002 13:46:59 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200210271853.g9RIrHV06188@devserv.devel.redhat.com>
Subject: Re: PATCH: ptrace support for fork/vfork/clone events [1/3]
To: dan@debian.org (Daniel Jacobowitz)
Date: Sun, 27 Oct 2002 13:53:17 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, landley@trommello.org (Rob Landley),
       alan@redhat.com (Alan Cox)
In-Reply-To: <20021027185038.GA27979@nevyn.them.org> from "Daniel Jacobowitz" at Oct 27, 2002 01:50:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've submitted this a couple of times and gotten no feedback, but I'm a
> sucker for pain, so here it is again - I'd really like to see this patch in
> 2.6.

I've been ignoring this because it doesn't appear to agree with what other
people tell me. For example why can't you do the fork trace by building
a trampoline ?
