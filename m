Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVANIuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVANIuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVANIuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:50:22 -0500
Received: from one.firstfloor.org ([213.235.205.2]:49348 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261750AbVANIsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:48:42 -0500
To: davids@webmaster.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA or not on dual Opteron
References: <E1CpCRr-0002lv-00@calista.eckenfels.6bone.ka-ip.net>
	<MDEHLPKNGKAHNMBLJOLKEEGKBBAB.davids@webmaster.com>
From: Andi Kleen <ak@muc.de>
Date: Fri, 14 Jan 2005 09:48:42 +0100
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEGKBBAB.davids@webmaster.com> (David
 Schwartz's message of "Fri, 14 Jan 2005 00:04:32 -0800")
Message-ID: <m1vfa0pf9x.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:
>
> 	2) How much overhead does the NUMA code add? On most of the benchmarks I've
> seen, the answer is a lot, so much that the memory access would have to be

Hmm? What benchmarks were that? That doesn't match my experience.

-Andi
