Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270617AbTGaWB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270508AbTGaWB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:01:59 -0400
Received: from [66.212.224.118] ([66.212.224.118]:6925 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270617AbTGaWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:01:56 -0400
Date: Thu, 31 Jul 2003 17:50:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: nbensa@yahoo.com
Cc: root@chaos.analogic.com, Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <200307311615.11660.nbensa@gmx.net>
Message-ID: <Pine.LNX.4.53.0307311747050.3779@montezuma.mastecende.com>
References: <20030730061454.GA19808@codepoet.org> <Pine.LNX.4.53.0307300855540.193@chaos>
 <200307311615.11660.nbensa@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Norberto BENSA wrote:

> Zwane Mwaikambo wrote:
> > On Tue, 29 Jul 2003, Richard B. Johnson wrote:
> > > If the machine had blanking disabled by default, then the
> > > usual SYS-V startup scripts could execute setterm to enable
> > > it IFF it was wanted.
> >
> > optimise for the common case, just fix your box and be done with it.
> 
> *IF* Linux primary target is the server market then, what kind of optimization 
> in console blanking if you need to hack your init script and insert "setterm 
> -blank 0" somewhere?? 

oh lord, you make it sound like a lot of work.

<insert reply about 'working out of the box'>

You're convincing the wrong person, it's not a difficult problem just send 
a patch already instead of slinging arguments for and against back and 
forth.

-- 
function.linuxpower.ca
