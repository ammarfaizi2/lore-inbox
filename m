Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUHDTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUHDTym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbUHDTym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:54:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:36808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267401AbUHDTyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:54:40 -0400
Date: Wed, 4 Aug 2004 12:51:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: axboe@suse.de, eric@cisu.net, kernel@kolivas.org, barryn@pobox.com,
       swsnyder@insightbb.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-Id: <20040804125129.704ba13a.akpm@osdl.org>
In-Reply-To: <210450000.1091647829@flay>
References: <200408021602.34320.swsnyder@insightbb.com>
	<410FA145.70701@kolivas.org>
	<20040804060625.GE10340@suse.de>
	<200408040614.30820.eric@cisu.net>
	<20040804130707.GN10340@suse.de>
	<20040804120633.4dca57b3.akpm@osdl.org>
	<210450000.1091647829@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I had a patch for a config option, ported forward by someone at IBM (I forget
>  who, possibly Dave) from Andrea's original. I think we finally decided 
>  (in consultation with Andrea) we could drop the complicated stuff he had
>  in the asm code, so it's pretty simple ... something like this:

I sent such a patch to the boss many moons ago and he said "go away, this
is a vendor-only thing". 
