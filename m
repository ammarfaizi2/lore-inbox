Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUGTMEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUGTMEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUGTMEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:04:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:55818 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265817AbUGTMEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:04:31 -0400
Date: 20 Jul 2004 14:04:30 +0200
Date: Tue, 20 Jul 2004 14:04:30 +0200
From: Andi Kleen <ak@muc.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1: Possible SCSI-related problem on dual Opteron w/ NUMA
Message-ID: <20040720120430.GB72772@muc.de>
References: <200407171826.03709.rjwysocki@sisk.pl> <200407172109.38088.rjwysocki@sisk.pl> <200407181448.14614.rjwysocki@sisk.pl> <200407182338.05282.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407182338.05282.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To clarify: in the above "your patch" means "x86_64-2.6.8rc1-1".  I should 
> have called it by name.  Sorry for the confusion,

Hmm. Do you have CONFIG_IOMMU_DEBUG on or iommu=force set? 

-Andi
