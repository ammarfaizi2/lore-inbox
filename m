Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTH2SD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTH2SD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:03:59 -0400
Received: from dsl-hkigw3g81.dial.inet.fi ([80.222.38.129]:64788 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S261874AbTH2SD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:03:57 -0400
Subject: Re: 2.4.22-jl9: speedstep-centrino.o: init_module: No such device
From: Jussi Laako <jussi.laako@pp.inet.fi>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308262206.37039.lkml@kcore.org>
References: <200308262206.37039.lkml@kcore.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062180293.3768.3.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 21:04:54 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 23:06, Jan De Luyck wrote:

> # modprobe speedstep-centrino
> /lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o: 
> init_module: No such device

Any details in dmesg output?


-- 
Jussi Laako <jussi.laako@pp.inet.fi>

