Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVK3AbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVK3AbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVK3AbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:31:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39388 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750721AbVK3AbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:31:20 -0500
Date: Wed, 30 Nov 2005 01:31:18 +0100
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
Message-ID: <20051130003118.GZ19515@wotan.suse.de>
References: <20051129033102.GA5706@mea-ext.zmailer.org> <p73veybh7tj.fsf@verdi.suse.de> <20051129235304.GB5706@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129235304.GB5706@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not that those explain all that much...

Can you send me your .config? If you have SPARSEMEM enabled can you
disable it?

-Andi
