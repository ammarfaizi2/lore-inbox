Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVLQDr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVLQDr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLQDr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:47:57 -0500
Received: from mx1.suse.de ([195.135.220.2]:49896 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751367AbVLQDr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:47:56 -0500
Date: Sat, 17 Dec 2005 04:47:55 +0100
From: Andi Kleen <ak@suse.de>
To: Gerhard Schrenk <deb.gschrenk@gmx.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Correction for broken MCFG tables on K8 breaks acpi for MSI S260
Message-ID: <20051217034755.GV23384@wotan.suse.de>
References: <20051217005109.GA11982@mailhub.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217005109.GA11982@mailhub.uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 01:51:09AM +0100, Gerhard Schrenk wrote:
> Hi,
> 
> commit d6ece5491ae71ded1237f59def88bcd1b19b6f60 breaks acpi for my
> Medion MD 95600 (aka MSI S260) notebook.

Should be already fixed in Linus' tree.

-Andi

