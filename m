Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTGVVQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269964AbTGVVQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:16:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23424 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S269736AbTGVVQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:16:07 -0400
Date: Tue, 22 Jul 2003 22:30:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ON TOPIC] HELP:  Getting lousy memory throughput from Abit KD7
Message-ID: <20030722213033.GA5122@mail.jlokier.co.uk>
References: <3F1711B5.9020800@techsource.com> <3F1D8EAB.6020801@techsource.com> <20030722210401.GA6952@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722210401.GA6952@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > 4) Linux has not properly set up the CPU caches.
> 
> Linux doesn't do anything with CPU caches.

Unless you count the MTRR adjustments that it does.

-- Jamie
