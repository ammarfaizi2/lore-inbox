Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCIRHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCIRHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVCIRHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:07:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:23174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262063AbVCIRHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:07:10 -0500
Date: Wed, 9 Mar 2005 09:09:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
In-Reply-To: <1110387326.28860.199.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503090908260.2530@ppc970.osdl.org>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org>
 <1110387326.28860.199.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Mar 2005, Alan Cox wrote:
> 
> This patch was discussed previously and declared incorrect.

Well, it was also declared as a "don't care" by Dave, I think, by virtue 
of nobody having ever complained.

		Linus
