Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVJGJwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVJGJwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJGJwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:52:03 -0400
Received: from ns1.suse.de ([195.135.220.2]:17579 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932362AbVJGJwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:52:02 -0400
Date: Fri, 7 Oct 2005 11:52:00 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       akpm@osdl.org
Subject: Re: [discuss] Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Message-ID: <20051007095200.GL6642@verdi.suse.de>
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510061242.26563.ak@suse.de> <20051006192052.B21395@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006192052.B21395@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can fix the API mess. Is there anything else you want me to do?

I think you overdid the sharing. Can you limit it to one file
and copy the stuff that doesn't fit easily? 

-Andi
