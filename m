Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTHGMCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTHGMCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:02:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45442 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270681AbTHGMCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:02:24 -0400
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Baron <jbaron@redhat.com>
In-Reply-To: <3F309FD8.8090105@gibraltar.at>
References: <Pine.LNX.4.44.0308051506570.26542-100000@dhcp64-178.boston.redhat.com>
	 <3F309FD8.8090105@gibraltar.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060257509.3168.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 12:58:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 07:27, Rene Mayrhofer wrote:
> Hi all,
> 
> The problem with pivot_root that appeared in 2.4.21-ac4 and the 
> 2.4.22-pre kernels is now solved (at least for my case) by applying the 
> trvial patch sent by Jason Baron.

The patch shouldnt be needed or make any difference. I have to
understand why its fixing the problem and fix it properly yet (or
someone does)

