Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCaKw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCaKw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCaKw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:52:56 -0500
Received: from everest.sosdg.org ([66.93.203.161]:57839 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261268AbVCaKwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:52:53 -0500
Message-ID: <424BD672.2070201@lovecn.org>
Date: Thu, 31 Mar 2005 18:52:34 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <20050331022554.735a1118.akpm@osdl.org>
In-Reply-To: <20050331022554.735a1118.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 218.24.164.184
X-Scan-Signature: e1130e2427bb9c4886ccddc7f2576ead
X-SA-Exim-Connect-IP: 218.24.164.184
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: 2.6.12-rc1-mm4
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0057]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.164.184 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
...
> 
> make-sysrq-f-call-oom_kill.patch
>   make sysrq-F call oom_kill()

Glad to see it fixed. :)

