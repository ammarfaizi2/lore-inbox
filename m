Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUDASPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDASPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:15:07 -0500
Received: from main.gmane.org ([80.91.224.249]:22985 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263026AbUDASPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:15:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Balazs Ree <ree@ree.hu>
Subject: Re: HPT370 locks up (2.4/2.6)
Date: Thu, 01 Apr 2004 20:14:05 +0200
Message-ID: <pan.2004.04.01.18.14.03.661751@ree.hu>
References: <pan.2004.03.30.12.36.03.326699@ree.hu> <200403311054.01626.vda@port.imtp.ilyichevsk.odessa.ua> <pan.2004.04.01.10.32.57.982363@ree.hu> <406BFFBA.2030502@cs.up.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 3e44b6eb.adsl.enternet.hu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Apr 2004 13:40:42 +0200, Jaco Kroon wrote:

> Weird question, but do you perhaps have the APIC enabled?

Yes.

But I have tried switching it off earlier - no success. Seems that at
least this particular problem is not APIC related.

-- 
Balazs REE

