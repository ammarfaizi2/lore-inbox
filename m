Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIAMuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIAMuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIAMub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:50:31 -0400
Received: from main.gmane.org ([80.91.224.249]:50130 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266362AbUIAMuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:50:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: Linux 2.6.8.1-ac1
Date: Wed, 01 Sep 2004 15:50:06 +0300
Message-ID: <pan.2004.09.01.12.50.04.116888@yahoo.com>
References: <20040831170839.GA18799@devserv.devel.redhat.com> <pan.2004.09.01.08.17.41.824046@yahoo.com> <1094035469.2374.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.196.100.133
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2004 11:44:30 +0100, Alan Cox wrote:
> On Mer, 2004-09-01 at 09:17, Paul Ionescu wrote:
>> Hi Alan,
>> 
>> I will try this patch on an IBM T41 Thinkpad, and I am interested in its
>> IDE Hotplug functionality.
>> Will I be able to swap IDE devices in my ultrabay without using "idectl
>> 1 rescan" (using this patch only) ?
>> Do I need any other special tool for ide hotswapping in this case? Or
>> should I wait for IDE hotplug at the device level ?
> 
> You need device level hotplug for the ultrabay drive rather than
> controller level. Thats next on the hit list after various other non IDE
> jobs.

OK, thanks for the info.
I'll wait a little bit for that patch then.



