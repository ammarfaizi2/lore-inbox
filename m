Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUCZPUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbUCZPUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:20:43 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:14208 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S264039AbUCZPUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:20:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
In-Reply-To: <BAY16-F37GnEErE7noj0001bec0@hotmail.com>
References: <BAY16-F37GnEErE7noj0001bec0@hotmail.com>
Message-Id: <E1B6t8T-0000KZ-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Fri, 26 Mar 2004 15:20:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
>I think the real question is this: if this binary blob is not GPL, then how 
>can it be in the kernel? It should be pulled out and put in a separate file, 
>which can be loaded with the firmware mechanism.

Correct.

>If it is firmware, then would it be legal to reverse engineer the assembler, 
>assuming one can find the instruction set for the chip?

That depends on your local jurisdiction.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
