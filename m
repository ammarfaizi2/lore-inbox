Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVAGIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVAGIYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVAGIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:24:39 -0500
Received: from mail.delphin-computer.de ([217.28.97.3]:29569 "EHLO
	exchange2000.leo.leo-computer.local") by vger.kernel.org with ESMTP
	id S261313AbVAGIVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:21:43 -0500
From: Andreas Schnaiter <andreas.schnaiter@leo-computer.de>
Organization: LEO Gesellschaft =?iso-8859-1?q?f=FCr_Computer_=26_Kommunikation?= mbH
To: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 3996] New: system hangs on boot - VIA, SMP, PIII 1GHz
Date: Fri, 7 Jan 2005 09:21:26 +0100
User-Agent: KMail/1.7.2
References: <200501051942.j05JgkcQ013658@fire-1.osdl.org> <20050105134957.0d5eef84.akpm@osdl.org>
In-Reply-To: <20050105134957.0d5eef84.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501070921.27107.andreas.schnaiter@leo-computer.de>
X-OriginalArrivalTime: 07 Jan 2005 08:26:17.0468 (UTC) FILETIME=[8EFEC3C0:01C4F492]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll leave that assertion to somebody with more knowledge than me, but it 
seems related to APIC, yes.
Sorry, I've only tried 2.6.7 through 2.6.10, but I'll try some earlier 2.6 
versions today, although I don't expect anything else to happen, since this 
problem also occurs on 2.4.
I'm sorry, I don't know how to gather more information which could be helpful 
for debugging if I can't even get into a shell ...
is there a kernel parameter or something like alike to collect more debugging 
information ?

On Wednesday 05 January 2005 22:49, Andrew Morton wrote:
> Seems to be related to APIC interrupt startup, yes?  Did any earlier 2.6
> kernel work correctly?
> 

-- 
Mit freundlichen Grüßen / With best regards
Leo Gesellschaft für Computer und Kommunikation mbH

Andreas Schnaiter
Programmierung

public GPG/PGP key | öffentlicher GPG/PGP Schlüssel
http://www.leo-computer.de/keys/andreas_schnaiter.asc
