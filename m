Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUATNdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUATNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:33:41 -0500
Received: from grex.cyberspace.org ([216.93.104.34]:15890 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S265494AbUATNdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:33:40 -0500
From: Andrew Halliwell <spike1@cyberspace.org>
Message-Id: <200401201334.IAA01060@grex.cyberspace.org>
Subject: AMD64/3ware/8Gig RAM and iommu=fullflush
To: linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2004 08:34:17 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to find information about the iommu=fullflush kernel switch
and was wondering if anyone had any information on what the actual
performance hit is, forcing it to write out its disk cache every write, or
whatever it does?

It must slow things down, but I was wondering how much.

Also, as this was admittedly a kludge, how far off is a more permanent
solution to the 3ware 4+gig/32bit only on a 64bit system problem?


Thanks
