Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270647AbTHACJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274953AbTHACJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:09:30 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:24704 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S270647AbTHACJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:09:29 -0400
Date: Fri, 1 Aug 2003 10:09:22 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       ianh@iahastie.clara.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
Message-ID: <20030801020922.GA3298@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F27817A.8000703@gts.it> <200307302346.02989.ianh@iahastie.local.net> <3F28C124.9070004@gts.it> <20030731050104.1b61990d.vmlinuz386@yahoo.com.ar> <20030731111728.GB1591@eugeneteo.net> <3F28FFAF.80905@gts.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F28FFAF.80905@gts.it>
X-Operating-System: Linux 2.6.0-test2-mm2-kj1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Stefano Rivoir">
> Eugene Teo wrote:
> 
> >One thing strange though.
> 
> [...]
> 
> Ok, I think I've found. It was very probably an old version of the
> synaptics module for X4.3 (it was ...p3). With the new driver,
> and with DRI too (along with test2-mm2 patch), it seems to be OK.
> At least, I've seen no hangs so far.

Hmm, can you explain the synaptics module? i experienced a hang again
last night. about 5-6 hours of no activities, and i can't get my box
back up again except with a hard reboot.

Eugene

> 
> Bye
> 
> -- 
> Stefano RIVOIR
> GTS Srl
> 
> 
> 
> 
