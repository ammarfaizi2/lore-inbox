Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDLPd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDLPd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDLPd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:33:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:62173 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750750AbWDLPd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:33:57 -0400
Date: Wed, 12 Apr 2006 17:33:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gabor Gombas <gombasg@sztaki.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata-pata works on ICH4-M
In-Reply-To: <20060412151930.GH4919@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
 <1144832990.1952.20.camel@localhost.localdomain>
 <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
 <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
>> which are generic
>
># hdparm -M 128 /dev/sda
>
The 's' is a classical indicator for somehow use of scsi. If that can be 
changed, the world is fine :)


Jan Engelhardt
-- 
