Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUJVVjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUJVVjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUJVVfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:35:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37346 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267904AbUJVVbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:31:18 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <4179623C.9050807@nortelnetworks.com>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098468316.5580.18.camel@krustophenia.net>
	 <4179623C.9050807@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098476905.19435.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 21:28:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 20:40, Chris Friesen wrote:
> x86 really could use an on-die register that increments at 1GHz independent of 
> clock speed and is synchronized across all CPUs in an SMP box.

HPET sort of is this but at chipset level

