Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUECNsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUECNsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUECNsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:48:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63134 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263687AbUECNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:48:37 -0400
Date: Mon, 3 May 2004 14:31:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040503123150.GA1188@openzaurus.ucw.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429064115.9A8E814D@damned.travellingkiwi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> echo -n disk > /proc/power/state

Use echo 4 > /proc/acpi/sleep, and vanilla kernels.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

