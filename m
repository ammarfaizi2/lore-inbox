Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266342AbUFQBSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266342AbUFQBSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbUFQBSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:18:17 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:46560 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S266342AbUFQBSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:18:08 -0400
In-Reply-To: <A06801158AE07847B27A52C1A074BC1D04C910B4@fmsmsx404.amr.corp.intel.com>
References: <A06801158AE07847B27A52C1A074BC1D04C910B4@fmsmsx404.amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2F53409E-BFFC-11D8-8574-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: eric@cisu.net, davids@webmaster.com, linux-kernel@vger.kernel.org,
       Erik Harrison <erikharrison@gmail.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: more files with licenses that aren't GPL-compatible
Date: Wed, 16 Jun 2004 21:18:05 -0400
To: "Wichmann, Mats D" <mats.d.wichmann@intel.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2004, at 19:47, Wichmann, Mats D wrote:
> Please keep distinct "ship with" in the sense of /inside/ the
> kernel and "ship with" in the sense of on the same distribution
> media.  The GPL also has explicit wording for the latter
> (you've already been quoted the words on the former):

Well the firmware is compiled to bytes within the _same_file_ as
the rest of the kernel.  That would match the usage of "inside" the
kernel.  Even if it's just a file with firmware bytes distributed in the
same tar file it's still very iffy.

> "In addition, mere aggregation of another work not based on the
> Program with the Program (or with a work based on the Program)
> on a volume of a storage or distribution medium does not bring
> the other work under the scope of this License. "

But we're not talking about an instance of aggregation here, this
is a derivative work.

Cheers,
Kyle Moffett

