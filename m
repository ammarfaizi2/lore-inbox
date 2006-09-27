Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031153AbWI0WaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031153AbWI0WaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031150AbWI0WaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:30:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8650 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031149AbWI0WaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:30:08 -0400
Message-ID: <451AFB6A.9010706@garzik.org>
Date: Wed, 27 Sep 2006 18:30:02 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, pmac@au1.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton	Blanchard's
 new hvcall interface
References: <200609271847.34258.ossthema@de.ibm.com>	<451AF29D.2030102@garzik.org> <17690.63978.373862.727933@cargo.ozlabs.ibm.com>
In-Reply-To: <17690.63978.373862.727933@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Jeff,
> 
>>> This eHEA patch reflects changes according to Anton's new hvcall interface
>>> which has been commited in Paul's git tree:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
>> When is this going upstream?  I don't want things to get too out-of-sync.
> 
> It's upstream already, and currently the ehea driver in Linus' tree
> doesn't compile as a result.

Thanks for the clarification.  The original quoted text sorta implied 
the opposite.

	Jeff



