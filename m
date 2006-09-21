Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWIUAJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIUAJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIUAJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:09:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37323 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750764AbWIUAJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:09:10 -0400
Date: Wed, 20 Sep 2006 17:09:01 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: npiggin@suse.de, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920170901.38696df1.pj@sgi.com>
In-Reply-To: <6599ad830609201657h1756d28eh4a04f85467f30ed2@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	<20060920134903.fbd9fea8.pj@sgi.com>
	<6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
	<20060920140401.39cc88ab.pj@sgi.com>
	<6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
	<20060920165408.c10e8857.pj@sgi.com>
	<6599ad830609201657h1756d28eh4a04f85467f30ed2@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Indeed - although one of the advantages of the patch I sent is that it
> can continue to present exactly the same interface, and functionality,
> to userspace as the current cpusets code does.

I'll go for that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
