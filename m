Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWGCGCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWGCGCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGCGCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:02:15 -0400
Received: from gw.goop.org ([64.81.55.164]:27298 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751349AbWGCGCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:02:15 -0400
Message-ID: <44A8B2FC.6080806@goop.org>
Date: Sun, 02 Jul 2006 23:02:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
CC: cpufreq@lists.linux.org.uk, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to RAM regression tracked down
References: <1151837268.5358.10.camel@idefix.homelinux.org>	<44A80B20.1090702@goop.org> <1151880764.5358.32.camel@idefix.homelinux.org>
In-Reply-To: <1151880764.5358.32.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin wrote:
> Any link to the patch and the thread about the problem (if any)? Also,
> was the race introduced in 2.6.12-rc5-git6? If not, it's a completely
> different problem because my machine worked fine with 2.6.12-rc5-git5.
>   

It's in the thread on the cpufreq list titled "ondemand vs suspend"; 
Venkatesh Pallipadi posted the patch.

    J
