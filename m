Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTJNOdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTJNOdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:33:01 -0400
Received: from intra.cyclades.com ([64.186.161.6]:52445 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262378AbTJNOc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:32:58 -0400
Date: Tue, 14 Oct 2003 11:27:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Mark Williams (MWP)" <mwp@internode.on.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise Ultra133-TX2 (PCD20269).
In-Reply-To: <20031012121331.GA665@linux.comp>
Message-ID: <Pine.LNX.4.44.0310141126250.2790-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Oct 2003, Mark Williams (MWP) wrote:

> Hi all,
> Sorry if this post to the list is inapropriate, i havnt been on the
> kernel mailing list for long.
> 
> I am having rather ugly problems with this card using the PDC20269 chip.
> Almost as soon as either of the HDDs on the controller are used, the
> kernel hangs solid with a dump of debugging info.

> Ive tried moving cards, diff, ram, cpu, etc everything short of changing
> MB (never been a problem before installing this card), so im sure that
> its this new IDE controller card that is the problem.
> I have also tried changing interrupts via the BIOS to remove possible
> clashes, but it also has not helped.
> 
> I am getting this problem with both the 2.4.22 and the 2.6.0-test7
> kernels (tried different minimal configs).
> 
> Can anyone help me with this problem?
> If any other info is needed, please let me know.

Please copy the exact information after the hang and post it.

Thank you

