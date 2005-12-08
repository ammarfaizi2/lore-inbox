Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVLHGaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVLHGaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVLHGaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:30:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:50817 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030473AbVLHGav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:30:51 -0500
Date: Thu, 8 Dec 2005 07:30:50 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208063050.GL11190@wotan.suse.de>
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208053302.GA28201@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was seen with a .15rc5-git1 kernel.
> Is this something still living in your x86-64 patchset or -mm ?

Only the change for less additional CPUs. 

-Andi
