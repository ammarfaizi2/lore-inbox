Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968398AbWLEQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968398AbWLEQCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968397AbWLEQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:02:53 -0500
Received: from testure.choralone.org ([194.9.77.134]:49362 "EHLO
	testure.choralone.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968393AbWLEQCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:02:52 -0500
Date: Tue, 5 Dec 2006 11:02:50 -0500
From: Dave Jones <davej@kernelslacker.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205160250.GB9076@kernelslacker.org>
Mail-Followup-To: Dave Jones <davej@kernelslacker.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 08:40:24PM -0800, Andrew Morton wrote:
 
 > cpufreq-fix-bug-in-duplicate-freq-elimination-code-in-acpi-cpufreq.patch
 > remove-hotplug-cpu-crap-from-cpufreq.patch
 > cpufreq-select-consistently-re-2619-rc5-mm1.patch
 > cpufreq-set-policy-curfreq-on-initialization.patch
 > bug-fix-for-acpi-cpufreq-and-cpufreq_stats-oops-on-frequency-change-notification.patch
 > 
 > Sent to cpufreq maintainer

I'm travelling right now, and somehow managed to oops my home router
3000 miles away making it hard for me to access mail & stuff.
(That "page count went negative" BUG() bit me when I did a killall -9 vpnc)

Full bug report, and processing of this backlog will happen
as soon as I get back on Sunday :)

		Dave
