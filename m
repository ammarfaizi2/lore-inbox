Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265193AbUETT7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUETT7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUETT7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:59:55 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:14781 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265193AbUETT7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:59:54 -0400
Subject: Re: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
	 <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1085083195.4240.4.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-2mdk 
Date: Thu, 20 May 2004 21:59:55 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ifconfig stats, I have no error, no overruns or dropped packets.
And remove the acpi modules have no effect...

I've also done some tests with netperf
If I use a kernel 2.4.26 on my server, I have 48Mb/s from server to
laptop. With a 2.6.6 kernel on the both sides, it's only 30Mb/s

Laurent
Le jeu, 20/05/2004 à 21:34 +0200, Rudo Thomas a écrit :
> Maybe you hit the same problem that was written about a few days ago. The
> subject was "peculiar problem with 2.6, 8139too + ACPI". Search the archive.
> 
> Rudo.


