Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTJaARa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTJaARa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:17:30 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:6541 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262425AbTJaAR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:17:29 -0500
Date: Fri, 31 Oct 2003 00:16:08 +0000
From: Dave Jones <davej@redhat.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031001608.GJ11311@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com> <1067555512.16868.2.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067555512.16868.2.camel@glass.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 12:11:52AM +0100, Felipe Alfaro Solana wrote:
 > > Process scheduler improvements.
 > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > > - Another much talked about feature. Ingo Molnar reworked the process
 > >   scheduler to use an O(1) algorithm.  In operation, you should notice
 > >   no changes with low loads, and increased scalability with large numbers
 > >   of processes, especially on large SMP systems.
 > 
 > I think we should mention excellent Con Kolivas contributions to the 2.6
 > kernel scheduler. He did a great job in tunning the scheduler for
 > maximum interactive feeling.

With no disrespect to Con, I'm not going to do this, or I'll end up
spending far too much time adding credits to everyone whoever improved
something in 2.5.  There's a place for such stuff, and it's aptly named
'CREDITS' in toplevel of src dir.

		Dave

