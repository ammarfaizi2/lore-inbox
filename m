Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTK1L4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTK1L4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:56:39 -0500
Received: from ns.suse.de ([195.135.220.2]:7570 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262153AbTK1L4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:56:38 -0500
To: Raj <raju@mailandnews.com>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange behavior observed w.r.t 'su' command
References: <3FC707B6.1070704@mailandnews.com> <jeoeuw7pf7.fsf@sykes.suse.de>
	<yw1x65h43h3b.fsf@kth.se> <je3cc87oic.fsf@sykes.suse.de>
	<3FC72FE2.90807@mailandnews.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: He probably just wants to take over my CELLS and then EXPLODE
 inside me like a BARREL of runny CHOPPED LIVER!  Or maybe he'd
 like to PSYCHOLOGICALLY TERRORIZE ME until I have no objection
 to a RIGHT-WING MILITARY TAKEOVER of my apartment!!  I guess
 I should call AL PACINO!
Date: Fri, 28 Nov 2003 12:52:31 +0100
In-Reply-To: <3FC72FE2.90807@mailandnews.com> (Raj's message of "Fri, 28 Nov
 2003 16:52:10 +0530")
Message-ID: <jehe0o677k.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj <raju@mailandnews.com> writes:

> But why is it that after 'su - root', running 'ps' shows 'su' as a
> separate process, whereas, 'su - otheruser' and then 'ps' does not show
> su' in the process list ??

Because you didn't list all processes.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
