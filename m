Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTLET7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTLET7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:59:42 -0500
Received: from intra.cyclades.com ([64.186.161.6]:31693 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264375AbTLET6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:58:55 -0500
Date: Fri, 5 Dec 2003 17:02:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Peter Bergmann <bergmann.peter@gmx.net>
Cc: linux-kernel@vger.kernel.org, <nfedera@esesix.at>
Subject: Re: old oom-vm for 2.4.32 (was oom killer in 2.4.23)
In-Reply-To: <6021.1070636584@www2.gmx.net>
Message-ID: <Pine.LNX.4.44.0312051702010.5412-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Peter Bergmann wrote:

> If anyone  is interested:
> Norbert Federa sent me this link for a "quick&dirty" patch he made 
> for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including the
> old oom-killer  - without guarantee but it does work very well for me ...

I suppose the oom killer is the only reason for you using .22 VM correct?

Or do you have any other reason for this?

