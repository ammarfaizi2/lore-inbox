Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWBMPsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWBMPsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWBMPr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:47:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWBMPr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:47:58 -0500
Date: Mon, 13 Feb 2006 07:47:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Dittmer <jdi@l4x.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc3
In-Reply-To: <43F04780.7020605@l4x.org>
Message-ID: <Pine.LNX.4.64.0602130747300.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <43F04780.7020605@l4x.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Jan Dittmer wrote:
> 
> This breaks compilation on 3 archs compared to -rc2:
> 
> - mips: broke
> - sparc: broke
> - sparc64: broke

Should be ok in -git now, pls verify.

		Linus
