Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTEHSN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTEHSN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:13:27 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:4021 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S261820AbTEHSN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:13:26 -0400
From: root@mauve.demon.co.uk
Message-Id: <200305081826.TAA04803@mauve.demon.co.uk>
Subject: Re: Binary firmware in the kernel - licensing issues.
To: adam@yggdrasil.com (Adam J. Richter)
Date: Thu, 8 May 2003 19:26:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305081635.h48GZk007160@adam.yggdrasil.com> from "Adam J. Richter" at May 08, 2003 09:35:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> 
> 	Let's be clear: embedding binary firmware into a GPL'ed
> work is fine if the firmware contains no additional restriction
> beyond the GPL and complete source code for the firmware is
> included.  I think you understand this much already, but I just
> want to be clear about it.

> 	All three distribution options in section 3 of the version 2
> of the GNU General Public License require distribution or arrangments
> for distribution "machine-readable source code", and defines
> "source code" as "the preferred form of the work for making
> modifications to it."  That seems pretty clear to me.

So if you've got a CPU, that you have to load the microcode into before
fully booting, you can't run linux on it natively, unless the CPU maker
provides full microcode source? 
Presumably the "preferred form" clause would mean that there must 
be hardware documentation too.

And when is a binary a binary, and not a string constant?
