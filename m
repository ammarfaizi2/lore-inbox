Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753368AbWKCRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbWKCRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbWKCRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:08:08 -0500
Received: from raven.upol.cz ([158.194.120.4]:38286 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1753368AbWKCRIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:08:06 -0500
Date: Fri, 3 Nov 2006 17:14:43 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem for Linux
Message-ID: <20061103171443.GA16912@flower.upol.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz> <20061102174149.3578062d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102174149.3578062d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
[]
> From: Andrew Morton <akpm@osdl.org>
>
> As Mikulas points out, (1 << anything) won't be evaluating to zero.

How about integer overflow ?
____
