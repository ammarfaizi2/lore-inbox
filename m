Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVBXVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVBXVqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVBXVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:46:50 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:27223 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262502AbVBXVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:46:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=H56qSHdySV+ugmFARcAW9o9K5KeaiBVgOWWvhMrN33ARfn42+WVIm56HlbMyXTdV8kAcL/w+G4dtJUPMd+pQ7t9RAtcj/mOF9fjKTy5jTG43yC8wPhsysv3IRSYh+952AjgkQhtL+jxbBHAniwC9Pdg3PdBq4TOQDEpMgVBZh9Q=
Message-ID: <a728f9f905022413465b96acd4@mail.gmail.com>
Date: Thu, 24 Feb 2005 16:46:34 -0500
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: netdev@oss.sgi.com
Subject: Marvell 88W8310 and 88E8050 PCI Express support
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed most of the new AMD64 chipsets now include integrated
marvell GigE and wifi chips onboard.  I haven't been able to find much
on the status of linux support for these chips.  Apparently the PCIE
GigE chip only works with sk98lin and not skge:
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0010.html
Does anyone know if support for the chip is being added to skge?  The
88W8310 doesn't seem to be supported at all, at least not that I can
see.  Does anyone know the status of the 88W8310?  Are there any
experimental drivers?  Is Marvell friendly to opensource?  Are the
databooks available?

Thanks,

Alex

PS, please CC: me as I'm not subscribed.
