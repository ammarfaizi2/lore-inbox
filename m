Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271226AbUJVLls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271226AbUJVLls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271227AbUJVLls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:41:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271226AbUJVLlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:41:08 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       M <mru@mru.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
References: <41650CAF.1040901@unimail.com.au>
	<20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	<yw1x7jq2n6k3.fsf@mru.ath.cx>
	<20041007143245.GA1698@openzaurus.ucw.cz>
	<1097956343.2148.17.camel@krustophenia.net>
	<1097963167.13226.4.camel@localhost.localdomain>
	<1097976283.2148.34.camel@krustophenia.net>
	<1097979705.13269.9.camel@localhost.localdomain>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 22 Oct 2004 08:40:55 -0300
In-Reply-To: <1097979705.13269.9.camel@localhost.localdomain>
Message-ID: <oroeiv3rqw.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2004, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Yes, and most laptops have this problem. They use SMM traps to talk to
> the battery

Hmm...  Since the SMM on this AMD64 notebook we've been talking about
on the thread about USB handoff isn't exactly AMD64-compliant, could
this be the reason why I can't get battery information?  I'm yet to
install a 32-bit-only system on this box to see whether it makes any
difference.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
