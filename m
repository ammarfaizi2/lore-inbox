Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUAMVQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUAMVQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:16:45 -0500
Received: from main.gmane.org ([80.91.224.249]:24036 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265654AbUAMVPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:15:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 22:15:57 +0100
Message-ID: <1611511.Si9EDUbpBt@spamfreemail.de>
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131756.03852.bzolnier@elka.pw.edu.pl> <bu1ccg$ouh$1@sea.gmane.org> <200401131924.51778.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> On Tuesday 13 of January 2004 19:11, Jens Benecke wrote:
> 
>> PS: this worked in 2.4 (loading the IDE driver later as module, but
>> booting from IDE as well), why doesn't it work in 2.6 any more?
> 
> Because 2.6.x is different (most host drivers probe for drives themselves)
> and nobody fixed this issue :-).

Ok ... :) will reporting it here make somebody fix it for 2.6.2 or would I
need to file an official bug report on the kernel bugzilla website?


-- 
Jens Benecke
