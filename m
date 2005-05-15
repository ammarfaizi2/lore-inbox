Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVEOUpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVEOUpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVEOUob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:44:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6876 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261237AbVEOUo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:44:28 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116142233.6270.9.camel@laptopd505.fenrus.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
	 <1116093694.6007.15.camel@laptopd505.fenrus.org>
	 <1116098504.9141.31.camel@mindpipe>
	 <1116100126.6007.17.camel@laptopd505.fenrus.org>
	 <1116114052.9141.38.camel@mindpipe>
	 <1116142233.6270.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116189693.17990.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 May 2005 21:41:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-05-15 at 08:30, Arjan van de Ven wrote:
> stop entirely.... (and that is also happening more and more and linux is
> getting more agressive idle support (eg no timer tick and such patches)
> which will trigger bios thresholds for this even more too.

Cyrix did TSC stop on halt a long long time ago, back when it was worth
the power difference.

Alan

