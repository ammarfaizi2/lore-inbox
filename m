Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSIQWjn>; Tue, 17 Sep 2002 18:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSIQWjn>; Tue, 17 Sep 2002 18:39:43 -0400
Received: from ns.suse.de ([213.95.15.193]:53767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264650AbSIQWjm>;
	Tue, 17 Sep 2002 18:39:42 -0400
Date: Wed, 18 Sep 2002 00:44:42 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk, ak@suse.de,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020918004442.A32234@wotan.suse.de>
References: <p73vg54tjpl.fsf@oldwotan.suse.de> <1032298092.20498.21.camel@irongate.swansea.linux.org.uk> <20020917.141806.49377410.davem@redhat.com> <200209171502.04524.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209171502.04524.jamesclv@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know how Sun and SGI manage with their larger systems.  Either they 
> don't do clock sync, or they may have to make expensive tradeoffs.

I guess you could always run NTP between the different CPUs ;) ;) 

-Andi
