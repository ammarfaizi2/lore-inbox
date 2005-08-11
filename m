Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVHKPjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVHKPjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHKPjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:39:13 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:41599 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751068AbVHKPjL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:39:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WVNwDot99DCP/jv9FsjrNkYz7oXO+3cMbYmWT086ZzVkLY7wCGj6qL8hdHnDQlWuR3pJTNKWOjiq4t/5F2AymKq3emtwJRTc6mnjtNWrWH+j/6K8Yvu8EklwPu/63RhwSv16Y5kGikn89vx8aZ35l7042PrZzOaPqx3sOt3d1JU=
Date: Thu, 11 Aug 2005 17:39:03 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: rlrevell@joe-job.com, lgb@lgb.hu, AMartin@nvidia.com,
       linux-kernel@vger.kernel.org
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-Id: <20050811173903.e2eaa9ed.diegocg@gmail.com>
In-Reply-To: <42FB6C27.1010408@gmail.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
	<20050811070943.GB8025@vega.lgb.hu>
	<1123765523.32375.10.camel@mindpipe>
	<42FB6C27.1010408@gmail.com>
X-Mailer: Sylpheed version 2.1.0 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 11 Aug 2005 17:17:59 +0200,
Michael Thonke <iogl64nx@gmail.com> escribió:

> There is no other way to use a nearly good chipset for AMD64 cpus.
> Via's chipsets are really buggy not acceptable, so what else ULi/Ali who 
> cares where to buy?


HP, Sun & friends seem to use AMD chipsets (AMD64 has a serious lack of 
support from "serious" chipset makers - many people do argue
that the nvidias are far from being "good" chipsets) and they seem to
support linux, but it's not easy to find motherboards for amd64 cpus
with amd chipsets on them. Good chipsets seems to be one of
the reasons why some people keeps buying intel...
