Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCEDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUCEDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:55:59 -0500
Received: from ns.suse.de ([195.135.220.2]:16303 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262182AbUCEDz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:55:58 -0500
Date: Fri, 5 Mar 2004 04:55:59 +0100
From: Andi Kleen <ak@suse.de>
To: Peter Williams <peterw@aurema.com>
Cc: johnl@aurema.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
Message-Id: <20040305045559.3ffdb410.ak@suse.de>
In-Reply-To: <40467B1C.8080204@aurema.com>
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel>
	<fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel>
	<yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel>
	<40426E1C.8010806@aurema.com.suse.lists.linux.kernel>
	<p73k7224pdn.fsf@brahms.suse.de>
	<404554D8.5040800@aurema.com>
	<20040303165718.379f9151.ak@suse.de>
	<40467B1C.8080204@aurema.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Mar 2004 11:41:00 +1100
Peter Williams <peterw@aurema.com> wrote:


> BTW Could you try it with the X server reniced to -15?

It seems to be a bit better with -15 (or maybe I'm imagining that), but still 
noticeable.

-Andi
