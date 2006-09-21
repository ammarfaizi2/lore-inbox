Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWIUAuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWIUAuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWIUAuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:50:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:39144 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750779AbWIUAuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:50:03 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: menage@google.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
In-Reply-To: <20060920173317.2277bcce.pj@sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <1158780923.6536.110.camel@linuxchandra>
	 <6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
	 <1158798607.6536.112.camel@linuxchandra>
	 <20060920173317.2277bcce.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 17:50:00 -0700
Message-Id: <1158799800.6536.122.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 17:33 -0700, Paul Jackson wrote:
> Chandra wrote:
> > What I am wondering is that whether the tight coupling of rg and cpuset
> > (into a container data structure) is ok.
> 
> Just guessing wildly here, but I'd anticipate that at best we
> (resource groups and cpusets) would share container mechanisms,
> but not share the same container instances.

That is what my thinking too.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


