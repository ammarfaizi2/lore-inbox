Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTJCNOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 09:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbTJCNOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 09:14:36 -0400
Received: from www.wireboard.com ([216.151.155.101]:18137 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S263747AbTJCNOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 09:14:35 -0400
To: John Bradford <john@grabjohn.com>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, karim@opersys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
References: <E1A5M5a-00057S-00@wisbech.cl.cam.ac.uk>
	<200310031047.h93AlSWB000506@81-2-122-30.bradfords.org.uk>
From: Doug McNaught <doug@mcnaught.org>
Date: 03 Oct 2003 09:14:08 -0400
In-Reply-To: John Bradford's message of "Fri, 3 Oct 2003 11:47:28 +0100"
Message-ID: <m3ad8iihun.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> I think we might be talking about different things -  what I meant was
> if you run a kernel compiled to support Xen on X86 natively without
> Xen, is there a big performance penalty, not if you run a single VM in
> Xen? 

My understanding from reading the paper is that you can't do
this--'x86-xen' is a separate "architecture" and won't boot on the
bare metal.

-Doug
