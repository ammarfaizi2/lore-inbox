Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJMTip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJMTip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJMTip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:38:45 -0400
Received: from main.gmane.org ([80.91.229.2]:39398 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932162AbVJMTio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:38:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [patch 0/2] acpiphp: hotplug adapters with bridges on them
Date: Thu, 13 Oct 2005 14:29:12 +0300
Message-ID: <pan.2005.10.13.11.29.11.335682@yahoo.com>
References: <1128707145.11020.9.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2005 10:45:45 -0700, Kristen Accardi wrote:

> These 2 patches will allow adapters with p2p bridges on them to be
> successfully hotplugged using the acpiphp driver.  Currently, if you
> attempt to hotplug an adapter with a p2p bridge on it, the operation will
> fail because resources are not allocated to it properly.  These patches
> have had very limited testing as I only have one machine and one type of
> adapter to test this with.  I tested this with 2.6.14-rc2, but the patch
> applies fine to rc3 as well.

Is this patch supposed to allow me to hot-plug/hot-eject my laptop in its
docking station ?
I have an IBM T41 and a docking station with extra IDE/PCI/PCMCIA bus-es on it.
I've tried for a long time to make them work hot, but till now, I could
not make them work.
I can only use the docking station if I boot in it.

Thanks,
Paul

