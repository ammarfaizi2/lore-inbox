Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422967AbWJQAQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWJQAQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWJQAQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:16:07 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:39361 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1422967AbWJQAQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:16:05 -0400
Date: Tue, 17 Oct 2006 10:15:42 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
Message-ID: <20061017001542.GA27359@localhost.localdomain>
Mail-Followup-To: Yao Fei Zhu <walkinair@cn.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <4532613D.1090107@cn.ibm.com> <20061016014334.GA30921@localhost.localdomain> <4533C4E9.1040504@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4533C4E9.1040504@cn.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 01:44:09AM +0800, Yao Fei Zhu wrote:
[snip]
> > 
> David, I have verified this fix, it works fine for me, Thanks. What's the status of it? Submitted?

Yes, I've sent it to Santiago Leon, the ibmveth maintainer and also to
Jeff Garzik and Andrew Morton.  It is in Andrew's -mm tree already,
haven't heard from Santiago or Jeff.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
