Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIVRRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIVRRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUIVRRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:17:39 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:52315 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266376AbUIVRRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:17:30 -0400
Message-ID: <9e47339104092210173e55bcca@mail.gmail.com>
Date: Wed, 22 Sep 2004 13:17:05 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1095871863.18365.129.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414F111C.9030809@linuxtv.org> <41506D78.6030106@web.de>
	 <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
	 <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
	 <9e47339104092208403d9de6f4@mail.gmail.com>
	 <1095868579.18365.105.camel@localhost>
	 <9e4733910409220907727056b4@mail.gmail.com>
	 <1095871863.18365.129.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can this code be implemented in the current framework? Don't I need
the attach/detach_adapter hook which I can't get to from the algo_bit
code?

http://lkml.org/lkml/2004/9/21/181

-- 
Jon Smirl
jonsmirl@gmail.com
