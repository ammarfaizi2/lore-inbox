Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWCFSPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCFSPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCFSPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:15:24 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:41894 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751421AbWCFSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:15:24 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8218D46C-FB88-42B7-9310-989ACE7D5CEA@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: fixed assignment of BARs for a "hotplug" device
Date: Mon, 6 Mar 2006 12:15:33 -0600
To: pcihpd-discuss@lists.sourceforge.net
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was suggest to me to ask this question on the PCI hotplug list by  
GregKH.

I was wondering if there are any examples on how to assign a device  
fixed BARs.  In my situation I've got an FPGA in an embedded system.   
Other PCI devices (DSPs) expect the FPGA at a given PCI address.  I  
haven't found any examples or interfaces that let me do what I need  
and thus suggested the following to Greg:

http://marc.theaimsgroup.com/?l=linux-pci&m=114142619805420&w=2

Here's a link to the original discussion:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114140791428032&w=2

thanks

- kumar
