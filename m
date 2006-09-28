Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWI1TBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWI1TBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWI1TBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:01:31 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:18692 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030377AbWI1TBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:01:30 -0400
Date: Thu, 28 Sep 2006 21:00:53 +0200
From: thunder7@xs4all.nl
To: Steve Fox <drfickle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060928190053.GB5596@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060928014623.ccc9b885.akpm@osdl.org> <efh217$8au$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efh217$8au$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Fox <drfickle@us.ibm.com>
Date: Thu, Sep 28, 2006 at 05:50:31PM +0000
> On Thu, 28 Sep 2006 01:46:23 -0700, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> 
> Panic on boot. This machine booted 2.6.18-mm1 fine. em64t machine.
> 
> TCP bic registered
> TCP westwood registered
> TCP htcp registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Unable to handle kernel paging request at ffffffffffffffff RIP: 

I think you need to post additional details, such as .config files.
2.6.18-mm2 boots fine here (x86-64, X2 4600 cpu, smp)

Linux version 2.6.18-mm2 (jurriaan@middle) (gcc version 4.1.2 20060920 (prerelease) (Debian 4.1.1-14)) #5 SMP Thu Sep 28 19:56:29 CEST 2006
Command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ processors (version 2.00.00)

Kind regards,
Jurriaan
-- 
"I resent it as well," said Scharde. "I am working to keep my rage under
control."
        Jack Vance - Ecce and Old Earth
Debian (Unstable) GNU/Linux 2.6.18-mm2 2x4826 bogomips load 1.35
