Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTBFAVd>; Wed, 5 Feb 2003 19:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTBFAVd>; Wed, 5 Feb 2003 19:21:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15376 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264903AbTBFAVd>;
	Wed, 5 Feb 2003 19:21:33 -0500
Date: Wed, 5 Feb 2003 16:26:47 -0800
From: Greg KH <greg@kroah.com>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
Message-ID: <20030206002647.GA22537@kroah.com>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 05:13:53PM -0800, Andy Chou wrote:
> 1	|	drivers/hotplug/ibmphp_pci.c

Real problem, fixed in my trees now.

thanks,

greg k-h
