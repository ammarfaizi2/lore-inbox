Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUF3XSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUF3XSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUF3XSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:18:06 -0400
Received: from ozlabs.org ([203.10.76.45]:25987 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263117AbUF3XSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:18:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16611.18790.991027.731443@cargo.ozlabs.ibm.com>
Date: Thu, 1 Jul 2004 09:14:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: (resend) Janitor signature of rtas_call() routine
In-Reply-To: <20040630125351.U21634@forte.austin.ibm.com>
References: <20040629154202.N21634@forte.austin.ibm.com>
	<16610.42236.698377.733729@cargo.ozlabs.ibm.com>
	<20040630125351.U21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> Well, your patch is not in the ameslab tree :( at least as of friday 
> night.  I'm working off of ameslab, is there a different tree I should
> follow at this time?

We should all be working from the upstream kernel.org tree as much as
possible.  In the past we have used ameslab as a repository for the
ppc64 changes that were ready to go but which hadn't got upstream yet.
Now that our patches are going into the upstream BK repository quickly
and reliably there is much less need for ameslab.

If you have something you're working on that isn't ready to go
upstream just yet, post the patch periodically to linuxppc64-dev
and/or linux-kernel.  If other developers want to try your stuff
before it's quite ready they should be applying your patches to their
local trees.

Paul.
