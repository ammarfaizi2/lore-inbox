Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRANKpe>; Sun, 14 Jan 2001 05:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132013AbRANKpX>; Sun, 14 Jan 2001 05:45:23 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:8198 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131953AbRANKpS>; Sun, 14 Jan 2001 05:45:18 -0500
Date: Sun, 14 Jan 2001 10:45:02 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: <13920.979466751@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0101141041160.4887-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Keith Owens wrote:

> Note I said allowed, not supported.  I refuse to support any binary
> only modules, my standard response to problems logged against binary
> modules is "remove them and reproduce the problem".  Checking for ABI
> violations is not supporting binary modules, it is detecting that they
> are stuffed and telling the user to go pester their supplier instead of
> polluting l-k with questions that will be ignored.

Sensible. As long as it doesn't give rise to reports of the type "modutils
didn't whinge so it's not the binary-only module's fault."

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
