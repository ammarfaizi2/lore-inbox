Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTJaChz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 21:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJaChz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 21:37:55 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:45453 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262813AbTJaChx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 21:37:53 -0500
Date: Fri, 31 Oct 2003 02:30:59 +0000
From: Dave Jones <davej@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031023059.GL11311@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Levon <levon@movementarian.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com> <1067555512.16868.2.camel@glass.felipe-alfaro.com> <20031031001608.GJ11311@redhat.com> <20031031021425.GB24712@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031031021425.GB24712@compsoc.man.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 02:14:25AM +0000, John Levon wrote:

 > Given that Ingo's reworkings led to horrendous interactive performance
 > for many desktop users for a long time during 2.5, it seems a little odd
 > to prefer crediting Ingo over Con given what you've said.
 > mentioning that we have an O(1) scheduler, plus there has been
 > significant work on interactive performance.

Preference has nothing to do with it. It comes down to one
definitive source of information.

>From MAINTAINERS ..

SCHEDULER
P:  Ingo Molnar
M:  mingo@elte.hu
P:  Robert Love    [the preemptible kernel bits]
M:  rml@tech9.net
L:  linux-kernel@vger.kernel.org
S:  Maintained

Shall I add rml there too? How about the other dozen or so people
that hacked on O(1) over the last year or so?  Get real, I'm
not about to waste my time going over attributions, nor further
entertain any responses in this thread.

		Dave

