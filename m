Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUIPNa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUIPNa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIPNa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:30:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56005 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268058AbUIPNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:30:25 -0400
Subject: Re: 2.6.9-rc2-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@teleline.es>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916151052.5e567252.diegocg@teleline.es>
References: <20040916024020.0c88586d.akpm@osdl.org>
	 <20040916151052.5e567252.diegocg@teleline.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095337657.22739.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 13:27:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah this is the bug Paul nailed down, new patch later today that should
fix the ldisc change hang. Thanks for the report.

