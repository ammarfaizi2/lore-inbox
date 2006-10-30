Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWJ3XxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWJ3XxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWJ3XxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:53:19 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39818 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932474AbWJ3XxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:53:18 -0500
Date: Mon, 30 Oct 2006 15:55:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>,
       virtualization@lists.osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Message-ID: <20061030235504.GB5881@sequoia.sous-sol.org>
References: <20061029024504.760769000@sous-sol.org> <20061030231132.GA98768@muc.de> <20061030234215.GA5881@sequoia.sous-sol.org> <200610310046.01388.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310046.01388.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> I haven't tried it myself (my laptop was on battery all the time
> and I didn't want to drain it with a full rebuild ;-), there was just a report
> that it didn't work. Or maybe that was with an old patch. If it works it's fine.

Ah yes, I see the report, (it's against a patch that has been redone),
but I'll double check.

thanks,
-chris
