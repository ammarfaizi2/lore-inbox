Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTIOJc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbTIOJc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:32:27 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:35847 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261705AbTIOJc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:32:26 -0400
Date: Mon, 15 Sep 2003 11:32:22 +0200
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030915093221.GE2268@gamma.logic.tuwien.ac.at>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030914152755.GA27105@suse.de>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Son, 14 Sep 2003, Jens Axboe wrote:
> > Will there be a new incantation of the laptop-mode patch for 2.4.23-pre4
> 
> Sure, I'll done a new patch in the next few days. I don't know what aa
> patches you mean though? Are you trying to say that it conflicts with

The ones included into kernel 2.4.23-pre4 (stuff from -aa kernels).

> the -aa series? It should be trivial to fix up, just renumber the
> laptop-mode sysctls.

Ok, this was what I wanted to know. The rest I can do myself, thanks.

> I'll send it to Marcelo too for 2.4.23.

Good idea!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DORRIDGE (n.)
Technical term for one of the lame excuses written in very small print
on the side of packets of food or washing powder to explain why
there's hardly anything inside. Examples include 'Contents may have
settled in transit' and 'To keep each biscuit fresh they have been
individually wrapped in silver paper and cellophane and separated with
corrugated lining, a cardboard flap, and heavy industrial tyres'.
			--- Douglas Adams, The Meaning of Liff
