Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVAMUHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVAMUHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAMUDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:03:09 -0500
Received: from one.firstfloor.org ([213.235.205.2]:61891 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261483AbVAMT6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:58:38 -0500
To: linux-kernel@vger.kernel.org
Cc: han@mijncomputer.nl
Subject: Re: propolice support for linux
References: <20050113134620.GA14127@boetes.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 Jan 2005 20:58:31 +0100
In-Reply-To: <20050113134620.GA14127@boetes.org> (Han Boetes's message of
 "Thu, 13 Jan 2005 14:45:58 +0059")
Message-ID: <m1fz152ja0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Han Boetes <han@mijncomputer.nl> writes:

> And since most of the security-flaws in linux are buffer-overflows
> I would like to request that a patch based on this one is applied
> to the kernel so people can use this extension by default.

Not in the linux kernel. If you followed the last security issues
none of them involved a overrun stack buffer. In fact I can only
remember one stack buffer overflow at all in the kernel long ago.

-Andi

