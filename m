Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUBRR4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267672AbUBRR4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:56:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:26247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267668AbUBRR4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:56:46 -0500
Date: Wed, 18 Feb 2004 09:56:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Raphael Rigo <raphael.rigo@inp-net.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: New do_mremap vulnerabitily.
In-Reply-To: <4033841A.6020802@inp-net.eu.org>
Message-ID: <Pine.LNX.4.58.0402180954590.2686@home.osdl.org>
References: <4033841A.6020802@inp-net.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Raphael Rigo wrote:
>
> Since it seems nobody posted it yet (at least I hope so) :
> 
> http://www.isec.pl/vulnerabilities/isec-0014-mremap-unmap.txt

Fixed in 2.6.3 and 2.4.25 (and, I think, vendor kernels), please upgrade
if you allow local shell access to untrusted users.

		Linus
