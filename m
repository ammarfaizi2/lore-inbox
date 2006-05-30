Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWE3JMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWE3JMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWE3JMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:12:30 -0400
Received: from math.ut.ee ([193.40.36.2]:32183 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932201AbWE3JM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:12:29 -0400
Date: Tue, 30 May 2006 12:12:27 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prep ppc boot broken post rc5
In-Reply-To: <Pine.SOC.4.61.0605301159520.15775@math.ut.ee>
Message-ID: <Pine.SOC.4.61.0605301211240.15775@math.ut.ee>
References: <Pine.SOC.4.61.0605301159520.15775@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My Motorola Powerstack II Pro4000 (a PReP machine from Motorola) does not 
> boot in current -git. It worked fine in -rc5 except iptables (not tacked down 
> the breaking commit yet, sorry) but does not boot in current -git (neither 
> did it with a 2 days old checkout).

Sorry, only the 2 days old snapshot was broken, todays is OK - it just 
took long to boot, perhaps a routine fsck was done.

-- 
Meelis Roos (mroos@linux.ee)
