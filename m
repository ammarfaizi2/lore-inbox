Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUL3UlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUL3UlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUL3UlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:41:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:39614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261715AbUL3UlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:41:17 -0500
Date: Thu, 30 Dec 2004 12:40:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Georg C. F. Greve" <greve@fsfeurope.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
In-Reply-To: <m3is6k4oeu.fsf@reason.gnu-hamburg>
Message-ID: <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Georg C. F. Greve wrote:
> 
> This is what I could preserve in output from the crashes:

Any chance that you can get a full oops, with register info? Right now 
your errors only have the call trace, not the registers or the EIP 
itself..

If that's because it scrolled off the screen, one option is to use the 
extended VGA modes or fbcon to make the screen area bigger.. Or use a 
serial console..

		Linus
