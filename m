Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHKAOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHKAOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWHKAOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:14:42 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61940 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932368AbWHKAOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:14:41 -0400
Date: Thu, 10 Aug 2006 20:14:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pavel Machek <pavel@ucw.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
In-Reply-To: <20060809125840.GD3808@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0608102013450.1183@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
 <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
 <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com> <20060809120844.GD3747@elf.ucw.cz>
 <Pine.LNX.4.58.0608090831440.3177@gandalf.stny.rr.com> <20060809125840.GD3808@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Aug 2006, Pavel Machek wrote:

>
> Some process that is running and eating 99% cpu when it should not be
> running and doing anything?
> 								Pavel

Yeah, I've already looked for a rogue process, but the CPU is actually
pretty idle.

-- Steve
