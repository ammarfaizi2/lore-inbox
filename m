Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTEVSLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTEVSLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:11:22 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:45061 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262964AbTEVSLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:11:22 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Thu, 22 May 2003 13:23:52 -0500
From: <tripperda@nvidia.com>
Subject: Re: pat support in the kernel
Message-ID: <20030522182352.GC532@hygelac>
References: <20030520190017$773c@gated-at.bofh.it> <m38yt1igdh.fsf@averell.firstfloor.org> <20030520201855.GE1050@hygelac> <20030521093343.GA2819@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521093343.GA2819@averell>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the tips Andi,

The rmap lookups sound like a good route to go. I'll work on that and post another patch when I have something working. 

And I agree that a "first come, first serve" approach that fails any conflicting mapping attempts is a good route to go.

Terence
