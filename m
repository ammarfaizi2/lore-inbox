Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWKEQnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWKEQnm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWKEQnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:43:41 -0500
Received: from mx1.suse.de ([195.135.220.2]:53227 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161338AbWKEQnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:43:41 -0500
From: Andi Kleen <ak@suse.de>
To: caglar@pardus.org.tr
Subject: Re: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 17:40:47 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr>
In-Reply-To: <200611051507.37196.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611051740.47191.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 14:07, S.Çağlar Onur wrote:
> Hi;
> 
> 2.6.18, 2.6.18.1 and 2.6.18.2 still panics randomly (it seems this is not 
> related to smpreplacament bug solved in .2) 

How do you know this? 

And does it still happen in 2.6.19-rc4?

> in VmWare and Microsoft Virtual  
> PC and in order to confirm this bug is not our distro specific i downloaded 
> and tried latest OpenSuse also [1]  and [2] are screens captured by vmware 
> but exact same panic occurs in Virtual PC as reported to us in [3]. 

Always the same BUG()?

> I CC'ed  
> previous threads receivers also.
> 
> [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic.png
> [2] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic.png

There is just some rolling Turkish text there.

-Andi
