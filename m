Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269923AbUJMXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269923AbUJMXug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269919AbUJMXug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:50:36 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:9174 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269923AbUJMXu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:50:29 -0400
Date: Thu, 14 Oct 2004 01:51:18 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: 4level page tables for Linux
Message-ID: <20041013235118.GR17849@dualathlon.random>
References: <1097709734.2666.10890.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097709734.2666.10890.camel@cube>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 07:22:15PM -0400, Albert Cahalan wrote:
> I'd number going toward the page, because that's
> the order in which these things get walked.

I'd call the pml level 1 too, but in the specs is level 4.  So sticking
the specs numbering is going to generate less confusion. Otherwise when
we speak with somebody with hardware knowledge we say level 4 and he
understand the specs's level 1. I recall it already happened to me once ;).
