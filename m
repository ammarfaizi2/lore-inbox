Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWFLTPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWFLTPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFLTPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:15:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62125 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932097AbWFLTPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:15:04 -0400
Subject: Re: broken local_t on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1150136082.3062.26.camel@mindpipe>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <200606121848.05438.ak@suse.de>
	 <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
	 <200606121906.28692.ak@suse.de>  <1150136082.3062.26.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 19:46:16 +0100
Message-Id: <1150137976.25462.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-12 am 14:14 -0400, ysgrifennodd Lee Revell:
> I don't think that's the case anymore.  Ubuntu is the #1 distro and the
> latest release ships with preemption enabled.

I'd love to know how anyone measured that (or indeed any other similar
xyz distro or xyz freely distributable relicable product)

Perhaps the new Ubuntu super-army can fix or extend binutils to handle
the needed relocations if they want extra performance on pre-emption
kernels ?

Alan

