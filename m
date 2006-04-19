Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDSLFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDSLFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDSLFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:05:16 -0400
Received: from main.gmane.org ([80.91.229.2]:35749 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750830AbWDSLFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:05:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Honermeyer <maze@strahlungsfrei.de>
Subject: Re: 3w-9xxx status in kernel
Date: Wed, 19 Apr 2006 13:02:42 +0200
Message-ID: <e2558p$o5f$2@sea.gmane.org>
References: <4444D1D5.6070903@rubis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.school-scout.de
Mail-Copies-To: maze@strahlungsfrei.de
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

same problem over here. Why does the newest kernel contain an old version of
the 3w-9xxx driver? 

We are having performance problems using a 9550SX controller. Read
throughput (measured with hdparm) is worse than on a Desktop system. We are
considering trying to replace it with the newest driver from 3ware.com.

Greetz,
Martin


Stéphane Jourdois wrote:

> Hi,
> 
> I have a question about 3w-9xxx driver versions :
> 
> 3w-9xxx version in vanilla 2.6.16 is 2.26.02.005
> 3w-9xxx version in 2.6.17-rc1-mm2 is 2.26.02.006
> 
> but :
> 3w-9xxx version in 3ware.com 9.3.0.3 codebase is 2.26.04.007
> 
> 
> The documentation with 9.3.0.3 codebase says it will not works with
> kernel driver <2.26.04.004. But I observe it works fine with codebase
> 9.3.0.2 (the documentation says it should not).
> 
> What is current status of 3w-9xxx driver in 2.6 ?
> Will it works on a 9550SX using 9.3.0.3 firmware ?
> Could you update documentation about that somewhere, for exemple in
> 3w-9xxx.c header ?
> 
> Thanks very much.
> 


