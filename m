Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTHZUhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTHZUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:37:53 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:48029 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262667AbTHZUhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:37:52 -0400
Date: Tue, 26 Aug 2003 22:36:37 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-jl9: speedstep-centrino.o: init_module: No such device
Message-ID: <20030826203637.GA18392@brodo.de>
References: <200308262206.37039.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308262206.37039.lkml@kcore.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 10:06:36PM +0200, Jan De Luyck wrote:
> I just patched my 2.4.22 with this patch - so i can get centrino speedstep 
> support in 2.4 - but it won't load:
> 
> # modprobe speedstep-centrino
> /lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o: 
> init_module: No such device
> 
> Any ideas?

Could you post your /proc/cpuinfo to the cpufreq mailing list at
cpufreq@www.linux.org.uk, please?

TIA,
	Dominik
