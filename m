Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJKSQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJKSQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWJKSQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:16:04 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21904 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161109AbWJKSQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:16:02 -0400
Message-ID: <452D34DC.2060704@drzeus.cx>
Date: Wed, 11 Oct 2006 20:15:56 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Remove me from maintainers for serial and mmc
References: <20061003163611.GA10658@flint.arm.linux.org.uk>	<452CFCC7.7020508@drzeus.cx> <20061011094826.63719621.akpm@osdl.org>
In-Reply-To: <20061011094826.63719621.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thanks.  Please send a MAINTAINERS patch.
>   

Some practical questions for my new role. I intend to set up a public
git repository (preferably on kernel.org, but I don't currently know the
criteria there) as a means to expose my patches.

>From what I've observed, the work flow is something like this:

Have a "for-andrew" and a "for-linus" branch, depending on stuff for -mm
or the main tree. Moving stuff between the two will be done in my rep
and after which I send pull requests to LKML.

This might be a misunderstanding on my part, or for other reasons, not a
way you wish to work. So I'm open to input on how I should structure things.

Rgds
Pierre

