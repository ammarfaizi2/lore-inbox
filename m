Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268140AbUHFQVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268140AbUHFQVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268171AbUHFQUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:20:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268140AbUHFQSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:18:22 -0400
Date: Fri, 6 Aug 2004 12:17:59 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, <torvalds@osdl.org>
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
In-Reply-To: <m3wu0cgv6q.fsf@averell.firstfloor.org>
Message-ID: <Xine.LNX.4.44.0408061216210.22965-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Andi Kleen wrote:

> You could use .altinstructions to patch a jump in at runtime
> based on CPU capabilities. Assuming MMX is really faster of course.

Neat.  The latter could be measured at boot.


- James
-- 
James Morris
<jmorris@redhat.com>


