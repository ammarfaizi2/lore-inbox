Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSLCRuo>; Tue, 3 Dec 2002 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLCRun>; Tue, 3 Dec 2002 12:50:43 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:58350 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262730AbSLCRun>; Tue, 3 Dec 2002 12:50:43 -0500
Subject: Re: IBM/MontaVista Dynamic Power Management Project
From: Arjan van de Ven <arjanv@redhat.com>
To: Bishop Brock <bcbrock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.uk.org,
       linux-pm-devel@lists.sourceforge.net
In-Reply-To: <OF6879354C.0478D137-ON86256C84.005CA3C0@pok.ibm.com>
References: <OF6879354C.0478D137-ON86256C84.005CA3C0@pok.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 18:57:49 +0100
Message-Id: <1038938270.28176.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 18:46, Bishop Brock wrote:
> IBM and MontaVista have initiated a joint project to develop a
> dynamic power management control and policy mechanism for Linux
> for processors supporting dynamic voltage and frequency scaling.
> A paper describing the proposal can be obtained from
> 
> http://www.research.ibm.com/arl/projects/dpm.html
> 
> A working prototype of the proposed framework for
> the IBM PowerPC 405LP processor exists and will be made
> public in the near future.

any idea if/how this will fit into the existing cross platform cpufreq
framework ?
