Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVFMPNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVFMPNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFMPNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:13:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15833 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261616AbVFMPMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:12:49 -0400
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613135029.GC8810@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
	 <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
	 <20050611193500.GC1097@devserv.devel.redhat.com>
	 <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
	 <1118670162.13250.25.camel@localhost.localdomain>
	 <20050613135029.GC8810@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118675421.13770.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 16:10:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 14:50, Neil Horman wrote:
> You mean add the ability to monitor directories for changes to the ptrace
> interface entirely?

If you are using it for debugging and tracking file accesses then ptrace
seems to be the right interface. 

Alan

