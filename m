Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292942AbSBVSDJ>; Fri, 22 Feb 2002 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292943AbSBVSC7>; Fri, 22 Feb 2002 13:02:59 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:44759 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S292942AbSBVSCx>;
	Fri, 22 Feb 2002 13:02:53 -0500
Date: Fri, 22 Feb 2002 13:03:15 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
To: linux-kernel@vger.kernel.org
Message-id: <1014400995.1811.30.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying to suspend my A30P, the screen goes black, and then about a 
> second later, I have this on the console (and syslog of course): 
[...] 
> 
> EIP:    0010:[<f882a876>]    Tainted: PF 

What kernel modules do you have loaded when this happens? 





