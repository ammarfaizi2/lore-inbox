Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWFBDj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWFBDj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWFBDj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:39:29 -0400
Received: from gw.goop.org ([64.81.55.164]:63434 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751240AbWFBDj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:39:28 -0400
Message-ID: <447FB2EC.7050701@goop.org>
Date: Thu, 01 Jun 2006 20:39:24 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "zhao, forrest" <forrest.zhao@intel.com>
CC: Jens Axboe <axboe@suse.de>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org> <1149210165.13451.4.camel@forrest26.sh.intel.com>
In-Reply-To: <1149210165.13451.4.camel@forrest26.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhao, forrest wrote:
> According to our test of Hannes's patch, it's not sufficient to support
> AHCI suspend/resume.
>   
Yes.  I merged it into mm2, and it didn't make any difference.
> Now I'm writing a patch to try to provide complete support for AHCI
> suspend/resume and will send out patch soon, hopefully by the end of
> today.
Great, looking forward to it.

    J
