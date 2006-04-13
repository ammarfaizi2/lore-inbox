Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWDMWaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWDMWaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWDMWaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:30:12 -0400
Received: from rtr.ca ([64.26.128.89]:21425 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965005AbWDMWaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:30:10 -0400
Message-ID: <443ED0EF.6080909@rtr.ca>
Date: Thu, 13 Apr 2006 18:30:07 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Gabor Gombas <gombasg@sztaki.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org
Subject: Re: libata-pata works on ICH4-M
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu> <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr> <443ECEBF.9050604@rtr.ca>
In-Reply-To: <443ECEBF.9050604@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And actually, "hdparm -Mnnn /dev/sda" does work today.

So it can set the Acoustic parameters just fine,
it just cannot read back the setting.

Cheers
