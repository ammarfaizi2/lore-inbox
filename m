Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUFWSro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUFWSro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUFWSrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:47:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42454 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266609AbUFWSr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:47:27 -0400
Date: Wed, 23 Jun 2004 20:27:27 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>, Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Christoph Hellwig <hch@infradead.org>, jbglaw@lug-owl.de,
       linux-kernel@vger.kernel.org, miller@techsource.com
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040623182727.GH10954@marowsky-bree.de>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de> <40D99A93.8030900@techsource.com> <20040623150314.GA24169@infradead.org> <20040623160320.GA28370@vana.vc.cvut.cz> <20040623182613.GA1458@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040623182613.GA1458@ucw.cz>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-23T20:26:13,
   Vojtech Pavlik <vojtech@suse.cz> said:

> > vmnet module actually provides tun-like character device, but with several
> > differences:
> > * You can connect any number of userspace processes to it.
> > * You can connect kernel end to nothing (complete guest-host separation), or
> 
> These can be done purely in userspace - a daemon can exchange the data
> between the processes (VMs).

... as UML already does it, anyway. I'm pretty sure the various methods
UML uses are quite applicable to VM too.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

