Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWBGLcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWBGLcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWBGLcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:32:53 -0500
Received: from math.ut.ee ([193.40.36.2]:27569 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965028AbWBGLcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:32:52 -0500
Date: Tue, 7 Feb 2006 13:32:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Ed Sweetman <safemode@comcast.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <43E88480.1010303@comcast.net>
Message-ID: <Pine.SOC.4.61.0602071331421.16150@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
 <1139310335.18391.2.camel@localhost.localdomain> <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
 <43E88480.1010303@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was under the impression that libata pata and ide drivers are mutually 
> exclusive.  You're not  supposed to be using both at the same time unless 
> they're for completely different controllers.

I _was_ only using libata. The two generic (PCI and ISA) IDE drivers are 
in libata too in addition to the old ide code.

-- 
Meelis Roos (mroos@linux.ee)
