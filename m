Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbUAVTyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUAVTyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:54:21 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:520 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266422AbUAVTyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:54:16 -0500
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Dave Jones <davej@redhat.com>, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 22 Jan 2004 13:53:38 -0600
From: <tripperda@nvidia.com>
Subject: Re: 2.6 agpgart and acpi standby/resume
Message-ID: <20040122195338.GB590@hygelac>
References: <20040122185807.GD506@hygelac> <20040122194404.GA9807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122194404.GA9807@redhat.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok thanks. can you consider the patch I attached to the first email as submitted and verified? I'll send more as I run across them.

Thanks,
Terence

On Thu, Jan 22, 2004 at 07:44:04PM +0000, davej@redhat.com wrote:
> On Thu, Jan 22, 2004 at 12:58:07PM -0600, Terence Ripperda wrote:
> 
>  > I'm curious why support was only added for 2 cases, instead of reconfiguring
>  > the chipset in every case. Is this because there were problems with some
>  > drivers, or is support added only on an "as-needed" basis?
> 
> The latter, though more an "as-tested" basis.
> 
> 		Dave
