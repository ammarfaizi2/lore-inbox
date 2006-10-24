Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWJXIRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWJXIRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWJXIRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:17:32 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:40967 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1030212AbWJXIRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:17:30 -0400
Date: Tue, 24 Oct 2006 10:17:25 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rt6] BUG / typo
In-Reply-To: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610241003280.1852@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Guennadi Liakhovetski wrote:

> [22644.590000] BUG: scheduling with irqs disabled: posix_cpu_timer/0x00000001/2
> [22644.590000] caller is schedule+0x10/0x118
[...]

Hm, got the same BUG with the patch from the previous email. Looking 
further, unless somebody has an idea?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
