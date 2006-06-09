Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWFIGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWFIGcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWFIGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 02:32:12 -0400
Received: from mail.suse.de ([195.135.220.2]:9676 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965231AbWFIGcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 02:32:11 -0400
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what processor family does intel core duo L2400 belong to?
References: <4488B159.2070806@cmu.edu>
From: Andi Kleen <ak@suse.de>
Date: 09 Jun 2006 08:32:09 +0200
In-Reply-To: <4488B159.2070806@cmu.edu>
Message-ID: <p731wtyu9ee.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis <gnychis@cmu.edu> writes:

> I am configuring the 2.6.17 kernel for a new thinkpad x60s, and I am
> wondering what processor family to select.  The processor is an Intel
> Core Duo L2400, and the gcc people suggested using the prescott march
> for cflags.  It is *not* a celeron.
> 
> My guess is the "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" family,
> but maybe someone has a different opinion or can support it.

It's a renamed Pentium-M followon. Not related to Pentium 4.

-Andi

