Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTIPRXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTIPRXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:23:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:29588 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262465AbTIPRWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:22:50 -0400
Date: Tue, 16 Sep 2003 18:22:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Timothy Miller <miller@techsource.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Dave Jones <davej@redhat.com>,
       richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916172215.GC28457@mail.jlokier.co.uk>
References: <Pine.LNX.3.96.1030916094748.26515B-100000@gatekeeper.tmr.com> <3F672B55.3000600@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F672B55.3000600@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> How many bytes would that code require?

Once the kernel has booted, zero.

-- Jamie

