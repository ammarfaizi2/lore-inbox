Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030858AbWKOSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030858AbWKOSrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030861AbWKOSrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:47:24 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17377 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030858AbWKOSrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:47:23 -0500
Message-ID: <455B60E5.2040201@us.ibm.com>
Date: Wed, 15 Nov 2006 12:48:05 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC, Patch 0/1] OProfile for Cell: Initial profiling support --
 new patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I will be posting a patch that updates the OProfile kernel driver to 
enable it for the Cell Broadband Engine processor.  The patch is based 
on Arnd Bergmann's arnd6 patchset for 2.6.18  
(http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.18-arnd6/), 
with Kevin Corry's cbe_pmu_interrupt patch on applied on top.  Kevin 
Corry's patch was submitted to the mailing lists earlier today and can 
be found at:
 http://marc.theaimsgroup.com/?l=linux-kernel&m=116360639928471&w=2).

I will also post an OProfile userpsace patch to the oprofile-list that 
adds the necessary support for the Cell processor.

Thanks in advance for your review of this patch.

Maynard Johnson
LTC Power Linux Toolchain
507-253-2650

