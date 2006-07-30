Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWG3Reg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWG3Reg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWG3Reg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:34:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:18647 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932383AbWG3Ref (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:34:35 -0400
To: Avi Kivity <avi@argo.co.il>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <1154271283.2941.27.camel@laptopd505.fenrus.org>
	<44CCCE72.8030808@argo.co.il>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2006 19:34:29 +0200
In-Reply-To: <44CCCE72.8030808@argo.co.il>
Message-ID: <p73u04z2dzu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> writes:
> 
> It's also broken for x86-64, which uses sse for floating point, not
> the x87 fpu.

Sorry, that doesn't make sense.

-Andi
