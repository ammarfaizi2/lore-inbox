Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUECNt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUECNt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUECNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:48:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63390 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263708AbUECNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:48:37 -0400
Date: Mon, 3 May 2004 14:45:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040503124555.GB1188@openzaurus.ucw.cz>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is that true? We can see where the oops occurs. If it's in the 
> module,  nothing more needs to be said. If it's in the kernel itself, 
> we can check  our source. We could check all the calls the module 

We *could* do it, but it would take too much time and we
have better stuff to do.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

