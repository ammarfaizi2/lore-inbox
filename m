Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030715AbWJDR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWJDR4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWJDR4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:56:13 -0400
Received: from colin.muc.de ([193.149.48.1]:29203 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030715AbWJDR4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:56:11 -0400
Date: 4 Oct 2006 19:56:10 +0200
Date: Wed, 4 Oct 2006 19:56:10 +0200
From: Andi Kleen <ak@muc.de>
To: "S.??a??lar Onur" <caglar@pardus.org.tr>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ops] 2.6.18
Message-ID: <20061004175610.GA44911@muc.de>
References: <200610010332.52509.caglar@pardus.org.tr> <200610041638.25955.caglar@pardus.org.tr> <20061004144736.GA67993@muc.de> <200610041908.20822.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610041908.20822.caglar@pardus.org.tr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you misunderstand me or i cant explain well :(, plain 2.6.18 boots on 
> these system without a problem but same kernel in vmware oopses. Of course 
> this can be a just a vmware problem but i can reproduce this behaviour (same 
> kernel boots real system but oopes in vmware with same output) with 3 
> different normal desktop PC's and two different vmware server version.

Hmm, maybe vmware uses the PIT timer.

> > Perhaps you list your setup and your configuration and a boot log
> > for the working case? 
> 
> Ok, I'll send all configurations and logs

The log will tell that.

-Andi
