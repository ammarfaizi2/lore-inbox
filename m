Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbUKWAFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUKWAFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKWAD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:03:29 -0500
Received: from tantale.fifi.org ([216.27.190.146]:52628 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262478AbUKWADK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:03:10 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend/resume ceased to work with 2.4.28
References: <87zn1amuov.fsf@ceramic.fifi.org>
	<20041122173654.GA31848@logos.cnet>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 22 Nov 2004 16:03:05 -0800
In-Reply-To: <20041122173654.GA31848@logos.cnet>
Message-ID: <87mzx94ekm.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> On Sun, Nov 21, 2004 at 07:25:20PM -0800, Philippe Troin wrote:
> > Seen on a Dell Inspiron 3800 with BIOS revision A17.
> > 
> > APM suspend/resume works perfectly with 2.4.27 (or at least, as well
> > as APM can).
> > 
> > Since I did not see any differences in arch/i386/kernel/apm.c between
> > .27 and .28, I'm at loss to explain the problem.
> 
> Guess: Are you using ACPI ? 

ACPI is compiled in, but the kernel is booted with noacpi...

Phil.
